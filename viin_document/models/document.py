# -*- coding: utf-8 -*-

from odoo import models, fields, api, _
from odoo.exceptions import UserError
from odoo.tools import image_process

ICON_SVGS = ['addresses','archive','audio','binary','calendar','certificate','disk','document','font','image','javascript','pdf','presentation','print','script','spreadsheet','text','unknown','vector','video','web_code','web_style']
ICON_SVGS2 = {
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

    name = fields.Char('Name', copy=True, store=True, compute='_compute_name', inverse='_inverse_name')
    @api.depends('attachment_id.name')
    def _compute_name(self):
        for record in self:
            if record.attachment_name:
                record.name = record.attachment_name

    def _inverse_name(self):
        for record in self:
            if record.attachment_id:
                record.attachment_name = record.name
    active = fields.Boolean(default=True, string="Active")
    thumbnail = fields.Binary(readonly=1, store=True, attachment=True, compute='_compute_thumbnail')

    url = fields.Char('URL', index=True, size=1024, tracking=True) #rt
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

    attachment_id = fields.Many2one('ir.attachment', ondelete='cascade', auto_join=True, copy=False)
    attachment_name = fields.Char('Attachment Name', related='attachment_id.name', readonly=False)
    datas = fields.Binary(related='attachment_id.datas', related_sudo=True, readonly=False) #rt3
    file_size = fields.Integer(related='attachment_id.file_size', store=True)
    checksum = fields.Char(related='attachment_id.checksum')
    mimetype = fields.Char(related='attachment_id.mimetype', default='application/octet-stream') #rt2
    res_model = fields.Char(related='attachment_id.res_model', store=True)
    res_id = fields.Many2oneReference(related='attachment_id.res_id', store=True)
    description = fields.Text('Attachment Description', related='attachment_id.description', readonly=False)
   
    @api.depends('checksum')
    def _compute_thumbnail(self):
        for record in self:
            try:
                record.thumbnail = image_process(record.datas, size=(80, 80), crop='center')
            except UserError:
                record.thumbnail = False
    
   
    tag_ids = fields.Many2many('viin_document.tag', 'document_tag_rel', string="Tags") #rt
    partner_id = fields.Many2one('res.partner', string="Contact", tracking=True) #rt
    owner_id = fields.Many2one('res.users', default=lambda self: self.env.user.id, string="Owner",
                               tracking=True)
    folder_id = fields.Many2one('viin_document.folder',
                                string="Folder",
                                ondelete="restrict",
                                tracking=True,
                                required=True,
                                index=True)
    
    


    