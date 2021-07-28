# -*- coding: utf-8 -*-
from odoo import models, fields, api, _
from odoo.exceptions import ValidationError


class DocumentFolder(models.Model):
    _name = 'viin_document.folder'
    _description = 'Documents Folder'
    _parent_name = 'parent_folder_id'
    _order = 'sequence'

    @api.constrains('parent_folder_id')
    def _check_parent_folder_id(self):
        if not self._check_recursion():
            raise ValidationError(_('You cannot create recursive folders.'))

    def name_get(self):
        name_array = []
        hierarchical_naming = self.env.context.get('hierarchical_naming', True)
        for record in self:
            if hierarchical_naming and record.parent_folder_id:
                name_array.append((record.id, "%s / %s" % (record.parent_folder_id.name, record.name)))
            else:
                name_array.append((record.id, record.name))
        return name_array

    company_id = fields.Many2one('res.company', 'Company',
                                 help="This Folder will only be available to the selected company")
    parent_folder_id = fields.Many2one('viin_document.folder',
                                       string="Parent Folder",
                                       ondelete="cascade",
                                       help="A Folder will inherit the tags of its parent Folder")
    name = fields.Char(required=True, translate=True)
    description = fields.Html(string="Description", translate=True)
    document_ids = fields.One2many('viin_document.document', 'folder_id', string="Documents")
    sequence = fields.Integer('Sequence', default=10)
    cate_tag_ids = fields.One2many('viin_document.tag.cate', 'folder_id',
                                string="Tag Categories",
                                )
    write_group_ids = fields.Many2many('res.groups',
        string="Write Groups")
    read_group_ids = fields.Many2many('res.groups', 'viin_document_folder_read_groups',
        string="Read Groups")

    user_specific = fields.Boolean(string="Own Documents Only",
                                  )
    action_count = fields.Integer('Action Count', compute='_compute_action_count')
    document_count = fields.Integer('Document Count', compute='_compute_document_count')

    