# -*- coding: utf-8 -*-

from odoo import models, fields, api, _
from odoo.exceptions import UserError
from odoo.osv import expression
from odoo.tools import image_process
from ast import literal_eval
from dateutil.relativedelta import relativedelta
from collections import OrderedDict
import re

templates = ['addresses','archive','audio','binary','calendar','certificate','disk','document','font','image','javascript','pdf','presentation','print','script','spreadsheet','text','unknown','vector','video','web_code','web_style']
templates2 = {
    'archive':['zip','rar']
}
class Document(models.Model):
    _name = 'viin_document.document'
    _description = 'Document'
    _inherit = ['mail.thread.cc', 'mail.activity.mixin']
    _order = 'id desc'

    _sql_constraints = [
        ('attachment_unique', 'unique (attachment_id)', "This attachment is already a document"),
    ]

    # Attachment
    attachment_id = fields.Many2one('ir.attachment', ondelete='cascade', auto_join=True, copy=False)
    # attachment_name = fields.Char('Attachment Name', related='attachment_id.name', readonly=False)
    # attachment_type = fields.Selection(string='Attachment Type', related='attachment_id.type', readonly=False)
    datas = fields.Binary(related='attachment_id.datas', related_sudo=True, readonly=False) #rt3
    file_size = fields.Integer(related='attachment_id.file_size', store=True)
    checksum = fields.Char(related='attachment_id.checksum')
    mimetype = fields.Char(related='attachment_id.mimetype', default='application/octet-stream') #rt2
   
    res_model = fields.Char(related='attachment_id.res_model', store=True)
    res_id = fields.Many2oneReference(related='attachment_id.res_id', store=True)
    # res_name = fields.Char('Resource Name', related='attachment_id.res_name')
    # index_content = fields.Text(related='attachment_id.index_content')
    description = fields.Text('Attachment Description', related='attachment_id.description', readonly=False)

    # Versioning
    previous_attachment_ids = fields.Many2many('ir.attachment', string="History")

    # Document
    name = fields.Char(related='attachment_id.name', copy=True, store=True) #rt1
   
    active = fields.Boolean(default=True, string="Active")
    thumbnail = fields.Binary(readonly=1, store=True, attachment=True, compute='_compute_thumbnail')

    @api.depends('checksum')
    def _compute_thumbnail(self):
        for record in self:
            try:
                record.thumbnail = image_process(record.datas, size=(80, 80), crop='center')

            except UserError:
                record.thumbnail = False
    url = fields.Char('URL', index=True, size=1024, tracking=True) #rt
    res_model_name = fields.Char(compute='_compute_res_model_name', index=True)
    
    @api.depends('res_model')
    def _compute_res_model_name(self):
        for record in self:
            if record.res_model:
                model = self.env['ir.model'].name_search(record.res_model, limit=1)
                if model:
                    record.res_model_name = model[0][1]
                else:
                    record.res_model_name = False
            else:
                record.res_model_name = False
    type = fields.Selection([('url', 'URL'), ('binary', 'File'), ('empty', 'Request')],
                            string='Type', required=True, store=True, default='empty', change_default=True,
                            compute='_compute_type') #rt
    
    @api.depends('attachment_id', 'url')
    def _compute_type(self):
        for record in self:
            record.type = 'empty'
            if record.attachment_id:
                record.type = 'binary'
            elif record.url:
                record.type = 'url'
   
    tag_ids = fields.Many2many('documents.tag', 'document_tag_rel', string="Tags") #rt
    partner_id = fields.Many2one('res.partner', string="Contact", tracking=True) #rt
    owner_id = fields.Many2one('res.users', default=lambda self: self.env.user.id, string="Owner",
                               tracking=True) #rt
    # available_rule_ids = fields.Many2many('documents.workflow.rule', compute='_compute_available_rules',
    #                                       string='Available Rules')
    # @api.depends('folder_id')
    # def _compute_available_rules(self):
    #     """
    #     loads the rules that can be applied to the attachment.

    #     """
    #     self.available_rule_ids = False
    #     folder_ids = self.mapped('folder_id.id')
    #     rule_domain = [('domain_folder_id', 'parent_of', folder_ids)] if folder_ids else []
    #     # searching rules with sudo as rules are inherited from parent folders and should be available even
    #     # when they come from a restricted folder.
    #     rules = self.env['documents.workflow.rule'].sudo().search(rule_domain)
    #     for rule in rules:
    #         domain = []
    #         if rule.condition_type == 'domain':
    #             domain = literal_eval(rule.domain) if rule.domain else []
    #         else:
    #             if rule.criteria_partner_id:
    #                 domain = expression.AND([[['partner_id', '=', rule.criteria_partner_id.id]], domain])
    #             if rule.criteria_owner_id:
    #                 domain = expression.AND([[['owner_id', '=', rule.criteria_owner_id.id]], domain])
    #             if rule.create_model:
    #                 domain = expression.AND([[['type', '=', 'binary']], domain])
    #             if rule.required_tag_ids:
    #                 domain = expression.AND([[['tag_ids', 'in', rule.required_tag_ids.ids]], domain])
    #             if rule.excluded_tag_ids:
    #                 domain = expression.AND([[['tag_ids', 'not in', rule.excluded_tag_ids.ids]], domain])

    #         folder_domain = [['folder_id', 'child_of', rule.domain_folder_id.id]]
    #         subset = expression.AND([[['id', 'in', self.ids]], domain, folder_domain])
    #         document_ids = self.env['viin_document.document'].search(subset)
    #         for document in document_ids:
    #             document.available_rule_ids = [(4, rule.id, False)]


    lock_uid = fields.Many2one('res.users', string="Locked by") #rt
    is_locked = fields.Boolean(compute="_compute_is_locked", string="Locked") #rt

    def _compute_is_locked(self):
        for record in self:
            is_permit_user = (self.env.user == record.lock_uid or
                    self.env.is_admin() or
                    self.user_has_groups('viin_document.viin_document_group_manager'))
            record.is_locked = record.lock_uid and not is_permit_user
    # create_share_id = fields.Many2one('documents.share', help='Share used to create this document')
    # request_activity_id = fields.Many2one('mail.activity')

    # Folder
    folder_id = fields.Many2one('documents.folder',
                                string="Workspace",
                                ondelete="restrict",
                                tracking=True,
                                required=True,
                                index=True)
    company_id = fields.Many2one('res.company', string='Company', related='folder_id.company_id', readonly=True)
    group_ids = fields.Many2many('res.groups', string="Access Groups", readonly=True,
                                 help="This attachment will only be available for the selected user groups",
                                 related='folder_id.group_ids')

    download_url = fields.Char(compute='_compute_download_url')
    
    def _compute_download_url(self):
        for r in self:
            r.download_url = '/documents/content/%s' % r.id if r.type == 'binary' else False
    
    icon_file = fields.Char(compute='_compute_icon_file') #rt

    def _compute_icon_file(self):
        for r in self:
            if not r.mimetype:
                r.icon_file = False
                return
            match = False
            icon_file = 'unknown'
            for i in templates:
                if i in r.mimetype:
                    match = True
                    icon_file = i
                    break
            if match == False:
                for k,vs in templates2.items():
                    for i in vs:
                        if i in r.mimetype:
                            match = True
                            icon_file = k
                            break
            r.icon_file = icon_file

    icon_url = fields.Char(compute='_compute_icon_url') #rt

    def _compute_icon_url(self):
        for r in self:
            if r.thumbnail:
                url = 'documents/image/%s?field=thumbnail'%r.id
            elif r.icon_file:
                url = '/web/static/src/img/mimetypes/%s.svg'%r.icon_file
            else:
                url = False
            r.icon_url = url

    ### button ####

    def access_content(self):
        self.ensure_one()
        action = {
            'type': "ir.actions.act_url",
            'target': "new",
        }
        if self.url:
            action['url'] = self.url
        elif self.type == 'binary':
            action['url'] = '/documents/content/%s' % self.id
        return action

    def create_share(self):
        self.ensure_one()
        vals = {
            'type': 'ids',
            'document_ids': [(6, 0, self.ids)],
            'folder_id': self.folder_id.id,
        }
        return self.env['documents.share'].create_share(vals)

    def toggle_lock(self):
        """
        sets a lock user, the lock user is the user who locks a file for themselves, preventing data replacement
        and archive (therefore deletion) for any user but himself.

        Members of the group documents.group_document_manager and the superuser can unlock the file regardless.
        """
        self.ensure_one()
        if self.lock_uid:
            if self.env.user == self.lock_uid or self.env.is_admin() or self.user_has_groups(
                    'documents.group_document_manager'):
                self.lock_uid = False
        else:
            self.lock_uid = self.env.uid

    # Onchange
    @api.onchange('url')
    def _onchange_url(self):
        if self.url:
            if not self.name:
                self.name = self.url.rsplit('/')[-1]

    # Function
    
    @api.model
    def create(self, vals):
        attachment = False
        if vals.get('datas') and not vals.get('attachment_id'):
            keys = [key for key in vals if
                    self._fields[key].related and self._fields[key].related[0] == 'attachment_id']
            attachment_dict = {key: vals.pop(key) for key in keys if key in vals}
            attachment = self.env['ir.attachment'].create(attachment_dict)
            vals['attachment_id'] = attachment.id
        new_record = super(Document, self).create(vals)
        if attachment:
            attachment.write({'res_model': 'viin_document.document', 'res_id': new_record.id})
        return new_record

    