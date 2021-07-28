[1mdiff --git a/viin_document/__manifest__.py b/viin_document/__manifest__.py[m
[1mindex 38da246..be99b21 100644[m
[1m--- a/viin_document/__manifest__.py[m
[1m+++ b/viin_document/__manifest__.py[m
[36m@@ -28,7 +28,7 @@[m
         #data[m
         'data/documents_data.xml',[m
         #view[m
[31m-        'views/documents_views.xml',[m
[32m+[m[32m        # 'views/documents_views.xml',[m
         'views/vii_templates.xml',[m
         'views/vii_assets.xml',[m
         'views/documents_configs/documents_folder_views.xml',[m
[1mdiff --git a/viin_document/controllers/schema.py b/viin_document/controllers/schema.py[m
[1mindex ade391f..aead1f3 100644[m
[1m--- a/viin_document/controllers/schema.py[m
[1m+++ b/viin_document/controllers/schema.py[m
[36m@@ -92,7 +92,7 @@[m [mclass TagCategory(OdooObjectType):[m
     @staticmethod[m
     def resolve_tags(root, info, limit=80, offset=None):[m
         return info.context["env"]["viin_document.tag"].search([m
[31m-            [('facet_id','=', root.id)], limit=limit, offset=offset[m
[32m+[m[32m            [('cate_tag_id','=', root.id)], limit=limit, offset=offset[m
         )[m
     [m
 class Share(OdooObjectType):[m
[1mdiff --git a/viin_document/data/documents_data.xml b/viin_document/data/documents_data.xml[m
[1mindex 8f83a25..f412c03 100644[m
[1m--- a/viin_document/data/documents_data.xml[m
[1m+++ b/viin_document/data/documents_data.xml[m
[36m@@ -49,7 +49,7 @@[m
             <field name="sequence">13</field>[m
         </record>[m
 [m
[31m-        <!-- Facets internal -->[m
[32m+[m[32m        <!-- cate_tags internal -->[m
 [m
         <record id="documents_internal_status" model="viin_document.tag.cate">[m
             <field name="name">Status</field>[m
[36m@@ -69,7 +69,7 @@[m
             <field name="folder_id" ref="documents_internal_folder"/>[m
         </record>[m
 [m
[31m-        <!-- Facets finance -->[m
[32m+[m[32m        <!-- cate_tags finance -->[m
 [m
         <record id="documents_finance_status" model="viin_document.tag.cate">[m
             <field name="name">Status</field>[m
[36m@@ -90,7 +90,7 @@[m
         </record>[m
 [m
 [m
[31m-        <!-- Facets marketing -->[m
[32m+[m[32m        <!-- cate_tags marketing -->[m
 [m
         <record id="documents_marketing_assets" model="viin_document.tag.cate">[m
             <field name="name">Assets</field>[m
[36m@@ -102,73 +102,73 @@[m
 [m
         <record id="documents_internal_status_inbox" model="viin_document.tag">[m
             <field name="name">Inbox</field>[m
[31m-            <field name="facet_id" ref="documents_internal_status"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_status"/>[m
             <field name="sequence">2</field>[m
         </record>[m
 [m
         <record id="documents_internal_status_tc" model="viin_document.tag">[m
             <field name="name">To Validate</field>[m
[31m-            <field name="facet_id" ref="documents_internal_status"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_status"/>[m
             <field name="sequence">3</field>[m
         </record>[m
 [m
         <record id="documents_internal_status_validated" model="viin_document.tag">[m
             <field name="name">Validated</field>[m
[31m-            <field name="facet_id" ref="documents_internal_status"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_status"/>[m
             <field name="sequence">5</field>[m
         </record>[m
 [m
         <record id="documents_internal_status_deprecated" model="viin_document.tag">[m
             <field name="name">Deprecated</field>[m
[31m-            <field name="facet_id" ref="documents_internal_status"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_status"/>[m
             <field name="sequence">6</field>[m
         </record>[m
 [m
         <record id="documents_internal_knowledge_hr" model="viin_document.tag">[m
             <field name="name">HR</field>[m
[31m-            <field name="facet_id" ref="documents_internal_knowledge"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_knowledge"/>[m
             <field name="sequence">9</field>[m
         </record>[m
 [m
         <record id="documents_internal_knowledge_sales" model="viin_document.tag">[m
             <field name="name">Sales</field>[m
[31m-            <field name="facet_id" ref="documents_internal_knowledge"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_knowledge"/>[m
             <field name="sequence">9</field>[m
         </record>[m
 [m
         <record id="documents_internal_knowledge_legal" model="viin_document.tag">[m
             <field name="name">Legal</field>[m
[31m-            <field name="facet_id" ref="documents_internal_knowledge"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_knowledge"/>[m
             <field name="sequence">9</field>[m
         </record>[m
 [m
         <record id="documents_internal_knowledge_other" model="viin_document.tag">[m
             <field name="name">Other</field>[m
[31m-            <field name="facet_id" ref="documents_internal_knowledge"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_knowledge"/>[m
             <field name="sequence">10</field>[m
         </record>[m
 [m
         <record id="documents_internal_template_presentations" model="viin_document.tag">[m
             <field name="name">Presentations</field>[m
[31m-            <field name="facet_id" ref="documents_internal_template"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_template"/>[m
             <field name="sequence">10</field>[m
         </record>[m
 [m
         <record id="documents_internal_template_contracts" model="viin_document.tag">[m
             <field name="name">Contracts</field>[m
[31m-            <field name="facet_id" ref="documents_internal_template"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_template"/>[m
             <field name="sequence">10</field>[m
         </record>[m
 [m
         <record id="documents_internal_template_project" model="viin_document.tag">[m
             <field name="name">Project</field>[m
[31m-            <field name="facet_id" ref="documents_internal_template"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_template"/>[m
             <field name="sequence">10</field>[m
         </record>[m
 [m
         <record id="documents_internal_template_text" model="viin_document.tag">[m
             <field name="name">Text</field>[m
[31m-            <field name="facet_id" ref="documents_internal_template"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_internal_template"/>[m
             <field name="sequence">10</field>[m
         </record>[m
 [m
[36m@@ -176,67 +176,67 @@[m
 [m
         <record id="documents_finance_status_inbox" model="viin_document.tag">[m
             <field name="name">Inbox</field>[m
[31m-            <field name="facet_id" ref="documents_finance_status"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_status"/>[m
             <field name="sequence">6</field>[m
         </record>[m
 [m
         <record id="documents_finance_status_tc" model="viin_document.tag">[m
             <field name="name">To Validate</field>[m
[31m-            <field name="facet_id" ref="documents_finance_status"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_status"/>[m
             <field name="sequence">6</field>[m
         </record>[m
 [m
         <record id="documents_finance_status_validated" model="viin_document.tag">[m
             <field name="name">Validated</field>[m
[31m-            <field name="facet_id" ref="documents_finance_status"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_status"/>[m
             <field name="sequence">6</field>[m
         </record>[m
 [m
         <record id="documents_finance_documents_bill" model="viin_document.tag">[m
             <field name="name">Bill</field>[m
[31m-            <field name="facet_id" ref="documents_finance_documents"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_documents"/>[m
             <field name="sequence">5</field>[m
         </record>[m
 [m
         <record id="documents_finance_documents_expense" model="viin_document.tag">[m
             <field name="name">Expense</field>[m
[31m-            <field name="facet_id" ref="documents_finance_documents"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_documents"/>[m
             <field name="sequence">6</field>[m
         </record>[m
 [m
         <record id="documents_finance_documents_vat" model="viin_document.tag">[m
             <field name="name">VAT</field>[m
[31m-            <field name="facet_id" ref="documents_finance_documents"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_documents"/>[m
             <field name="sequence">7</field>[m
         </record>[m
 [m
         <record id="documents_finance_documents_fiscal" model="viin_document.tag">[m
             <field name="name">Fiscal</field>[m
[31m-            <field name="facet_id" ref="documents_finance_documents"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_documents"/>[m
             <field name="sequence">8</field>[m
         </record>[m
 [m
         <record id="documents_finance_documents_financial" model="viin_document.tag">[m
             <field name="name">Financial</field>[m
[31m-            <field name="facet_id" ref="documents_finance_documents"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_documents"/>[m
             <field name="sequence">9</field>[m
         </record>[m
 [m
         <record id="documents_finance_documents_Contracts" model="viin_document.tag">[m
             <field name="name">Contracts</field>[m
[31m-            <field name="facet_id" ref="documents_finance_documents"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_documents"/>[m
             <field name="sequence">10</field>[m
         </record>[m
 [m
         <record id="documents_finance_fiscal_year_2018" model="viin_document.tag">[m
             <field name="name" eval="str(datetime.now().year)"/>[m
[31m-            <field name="facet_id" ref="documents_finance_fiscal_year"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_fiscal_year"/>[m
             <field name="sequence">6</field>[m
         </record>[m
 [m
         <record id="documents_finance_fiscal_year_2017" model="viin_document.tag">[m
             <field name="name" eval="str(datetime.now().year-1)"/>[m
[31m-            <field name="facet_id" ref="documents_finance_fiscal_year"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_finance_fiscal_year"/>[m
             <field name="sequence">5</field>[m
         </record>[m
 [m
[36m@@ -244,25 +244,25 @@[m
 [m
         <record id="documents_marketing_assets_ads" model="viin_document.tag">[m
             <field name="name">Ads</field>[m
[31m-            <field name="facet_id" ref="documents_marketing_assets"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_marketing_assets"/>[m
             <field name="sequence">10</field>[m
         </record>[m
 [m
         <record id="documents_marketing_assets_brochures" model="viin_document.tag">[m
             <field name="name">Brochures</field>[m
[31m-            <field name="facet_id" ref="documents_marketing_assets"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_marketing_assets"/>[m
             <field name="sequence">11</field>[m
         </record>[m
 [m
         <record id="documents_marketing_assets_images" model="viin_document.tag">[m
             <field name="name">Images</field>[m
[31m-            <field name="facet_id" ref="documents_marketing_assets"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_marketing_assets"/>[m
             <field name="sequence">12</field>[m
         </record>[m
 [m
         <record id="documents_marketing_assets_Videos" model="viin_document.tag">[m
             <field name="name">Videos</field>[m
[31m-            <field name="facet_id" ref="documents_marketing_assets"/>[m
[32m+[m[32m            <field name="cate_tag_id" ref="documents_marketing_assets"/>[m
             <field name="sequence">13</field>[m
         </record>[m
 [m
[1mdiff --git a/viin_document/models/document.py b/viin_document/models/document.py[m
[1mindex b0d1432..9fabe5a 100644[m
[1m--- a/viin_document/models/document.py[m
[1m+++ b/viin_document/models/document.py[m
[36m@@ -9,8 +9,8 @@[m [mfrom dateutil.relativedelta import relativedelta[m
 from collections import OrderedDict[m
 import re[m
 [m
[31m-templates = ['addresses','archive','audio','binary','calendar','certificate','disk','document','font','image','javascript','pdf','presentation','print','script','spreadsheet','text','unknown','vector','video','web_code','web_style'][m
[31m-templates2 = {[m
[32m+[m[32mICON_SVGS = ['addresses','archive','audio','binary','calendar','certificate','disk','document','font','image','javascript','pdf','presentation','print','script','spreadsheet','text','unknown','vector','video','web_code','web_style'][m
[32m+[m[32mICON_SVGS2 = {[m
     'archive':['zip','rar'][m
 }[m
 class Document(models.Model):[m
[36m@@ -23,27 +23,17 @@[m [mclass Document(models.Model):[m
         ('attachment_unique', 'unique (attachment_id)', "This attachment is already a document"),[m
     ][m
 [m
[31m-    # Attachment[m
     attachment_id = fields.Many2one('ir.attachment', ondelete='cascade', auto_join=True, copy=False)[m
     attachment_name = fields.Char('Attachment Name', related='attachment_id.name', readonly=False)[m
[31m-    # attachment_type = fields.Selection(string='Attachment Type', related='attachment_id.type', readonly=False)[m
     datas = fields.Binary(related='attachment_id.datas', related_sudo=True, readonly=False) #rt3[m
     file_size = fields.Integer(related='attachment_id.file_size', store=True)[m
     checksum = fields.Char(related='attachment_id.checksum')[m
     mimetype = fields.Char(related='attachment_id.mimetype', default='application/octet-stream') #rt2[m
[31m-   [m
     res_model = fields.Char(related='attachment_id.res_model', store=True)[m
     res_id = fields.Many2oneReference(related='attachment_id.res_id', store=True)[m
[31m-    # res_name = fields.Char('Resource Name', related='attachment_id.res_name')[m
[31m-    # index_content = fields.Text(related='attachment_id.index_content')[m
     description = fields.Text('Attachment Description', related='attachment_id.description', readonly=False)[m
 [m
[31m-    # Versioning[m
     previous_attachment_ids = fields.Many2many('ir.attachment', string="History")[m
[31m-[m
[31m-    # Document[m
[31m-    # name = fields.Char(related='attachment_id.name', copy=True, store=True) #rt1[m
[31m-[m
     name = fields.Char('Name', copy=True, store=True, compute='_compute_name', inverse='_inverse_name')[m
     @api.depends('attachment_id.name')[m
     def _compute_name(self):[m
[36m@@ -176,13 +166,13 @@[m [mclass Document(models.Model):[m
                 return[m
             match = False[m
             icon_file = 'unknown'[m
[31m-            for i in templates:[m
[32m+[m[32m            for i in ICON_SVGS:[m
                 if i in r.mimetype:[m
                     match = True[m
                     icon_file = i[m
                     break[m
             if match == False:[m
[31m-                for k,vs in templates2.items():[m
[32m+[m[32m                for k,vs in ICON_SVGS2.items():[m
                     for i in vs:[m
                         if i in r.mimetype:[m
                             match = True[m
[36m@@ -326,17 +316,17 @@[m [mclass Document(models.Model):[m
     # Nay dung de test thoi[m
     def _get_processed_tags(self, domain, folder_id):[m
         """[m
[31m-        sets a group color to the tags based on the order of the facets (group_id)[m
[32m+[m[32m        sets a group color to the tags based on the order of the cate_tags (group_id)[m
         recomputed each time the search_panel fetches the tags as the colors depend on the order and[m
         amount of tag categories. If the amount of categories exceeds the amount of colors, the color[m
         loops back to the first one.[m
         """[m
         tags = self.env['viin_document.tag']._get_tags(domain, folder_id)[m
[31m-        facets = list(OrderedDict.fromkeys([tag['group_id'] for tag in tags]))[m
[31m-        facet_colors = self.env['viin_document.tag.cate'].FACET_ORDER_COLORS[m
[32m+[m[32m        cate_tags = list(OrderedDict.fromkeys([tag['group_id'] for tag in tags]))[m
[32m+[m[32m        cate_tag_colors = self.env['viin_document.tag.cate'].cate_tag_ORDER_COLORS[m
         for tag in tags:[m
[31m-            color_index = facets.index(tag['group_id']) % len(facet_colors)[m
[31m-            tag['group_hex_color'] = facet_colors[color_index][m
[32m+[m[32m            color_index = cate_tags.index(tag['group_id']) % len(cate_tag_colors)[m
[32m+[m[32m            tag['group_hex_color'] = cate_tag_colors[color_index][m
 [m
         return tags[m
 [m
[1mdiff --git a/viin_document/models/folder.py b/viin_document/models/folder.py[m
[1mindex 15c62c7..9373933 100644[m
[1m--- a/viin_document/models/folder.py[m
[1m+++ b/viin_document/models/folder.py[m
[36m@@ -44,7 +44,7 @@[m [mclass DocumentFolder(models.Model):[m
     document_ids = fields.One2many('viin_document.document', 'folder_id', string="Documents")[m
     sequence = fields.Integer('Sequence', default=10)[m
     share_link_ids = fields.One2many('viin_document.share', 'folder_id', string="Share Links")[m
[31m-    facet_ids = fields.One2many('viin_document.tag.cate', 'folder_id',[m
[32m+[m[32m    cate_tag_ids = fields.One2many('viin_document.tag.cate', 'folder_id',[m
                                 string="Tag Categories",[m
                                 help="Tag categories defined for this workspace")[m
     group_ids = fields.Many2many('res.groups',[m
[1mdiff --git a/viin_document/models/tags.py b/viin_document/models/tags.py[m
[1mindex 4d3a0b5..28506fe 100644[m
[1m--- a/viin_document/models/tags.py[m
[1m+++ b/viin_document/models/tags.py[m
[36m@@ -8,21 +8,21 @@[m [mclass TagsCategories(models.Model):[m
     _description = "Category"[m
     _order = "sequence, name"[m
 [m
[31m-    # the colors to be used to represent the display order of the facets (tag categories), the colors[m
[32m+[m[32m    # the colors to be used to represent the display order of the cate_tags (tag categories), the colors[m
     # depend on the order and amount of fetched categories[m
     # currently used in the searchPanel and the kanban view and should match across the two.[m
     #mở lại để test[m
[31m-    FACET_ORDER_COLORS = ['#F06050', '#6CC1ED', '#F7CD1F', '#814968', '#30C381', '#D6145F', '#475577', '#F4A460',[m
[32m+[m[32m    cate_tag_ORDER_COLORS = ['#F06050', '#6CC1ED', '#F7CD1F', '#814968', '#30C381', '#D6145F', '#475577', '#F4A460',[m
                           '#EB7E7F', '#2C8397'][m
 [m
     folder_id = fields.Many2one('viin_document.folder', string="Workspace", ondelete="cascade")[m
     name = fields.Char(required=True, translate=True)[m
[31m-    tag_ids = fields.One2many('viin_document.tag', 'facet_id')[m
[32m+[m[32m    tag_ids = fields.One2many('viin_document.tag', 'cate_tag_id')[m
     sequence = fields.Integer('Sequence', default=10)[m
     tooltip = fields.Char(help="Text shown when hovering on this tag category or its tags", string="Tooltip")[m
 [m
     _sql_constraints = [[m
[31m-        ('name_unique', 'unique (folder_id, name)', "Facet already exists in this folder"),[m
[32m+[m[32m        ('name_unique', 'unique (folder_id, name)', "cate_tag already exists in this folder"),[m
     ][m
 [m
 [m
[36m@@ -31,14 +31,14 @@[m [mclass Tags(models.Model):[m
     _description = "Tag"[m
     _order = "sequence, name"[m
 [m
[31m-    folder_id = fields.Many2one('viin_document.folder', string="Workspace", related='facet_id.folder_id', store=True,[m
[32m+[m[32m    folder_id = fields.Many2one('viin_document.folder', string="Workspace", related='cate_tag_id.folder_id', store=True,[m
                                 readonly=False)[m
[31m-    facet_id = fields.Many2one('viin_document.tag.cate', string="Category", ondelete='cascade', required=True)[m
[32m+[m[32m    cate_tag_id = fields.Many2one('viin_document.tag.cate', string="Category", ondelete='cascade', required=True)[m
     name = fields.Char(required=True, translate=True)[m
     sequence = fields.Integer('Sequence', default=10)[m
 [m
     _sql_constraints = [[m
[31m-        ('facet_name_unique', 'unique (facet_id, name)', "Tag already exists for this facet"),[m
[32m+[m[32m        ('cate_tag_name_unique', 'unique (cate_tag_id, name)', "Tag already exists for this cate_tag"),[m
     ][m
 [m
     def name_get(self):[m
[36m@@ -46,19 +46,19 @@[m [mclass Tags(models.Model):[m
         if self._context.get('simple_name'):[m
             return super(Tags, self).name_get()[m
         for record in self:[m
[31m-            names.append((record.id, "%s > %s" % (record.facet_id.name, record.name)))[m
[32m+[m[32m            names.append((record.id, "%s > %s" % (record.cate_tag_id.name, record.name)))[m
         return names[m
 [m
     @api.model[m
     def _get_tags(self, domain, folder_id):[m
         """[m
[31m-        fetches the tag and facet ids for the document selector (custom left sidebar of the kanban view)[m
[32m+[m[32m        fetches the tag and cate_tag ids for the document selector (custom left sidebar of the kanban view)[m
         """[m
         documents = self.env['viin_document.document'].search(domain)[m
[31m-        # folders are searched with sudo() so we fetch the tags and facets from all the folder hierarchy (as tags[m
[31m-        # and facets are inherited from ancestor folders).[m
[32m+[m[32m        # folders are searched with sudo() so we fetch the tags and cate_tags from all the folder hierarchy (as tags[m
[32m+[m[32m        # and cate_tags are inherited from ancestor folders).[m
         folders = self.env['viin_document.folder'].sudo().search([('parent_folder_id', 'parent_of', folder_id)])[m
[31m-        self.flush(['sequence', 'name', 'facet_id'])[m
[32m+[m[32m        self.flush(['sequence', 'name', 'cate_tag_id'])[m
         self.env['viin_document.tag.cate'].flush(['sequence', 'name', 'tooltip'])[m
         query = """[m
             SELECT  tag_cate.sequence AS group_sequence,[m
[36m@@ -68,7 +68,7 @@[m [mclass Tags(models.Model):[m
                     viin_document_tag.id AS id,[m
                     COUNT(rel.viin_document_document_id) AS __count[m
             FROM viin_document_tag[m
[31m-                JOIN viin_document_tag_cate tag_cate ON viin_document_tag.facet_id = tag_cate.id[m
[32m+[m[32m                JOIN viin_document_tag_cate tag_cate ON viin_document_tag.cate_tag_id = tag_cate.id[m
                     AND tag_cate.folder_id = ANY(%s)[m
                 LEFT JOIN document_tag_rel rel ON viin_document_tag.id = rel.viin_document_tag_id[m
                     AND rel.viin_document_document_id = ANY(%s)[m
[1mdiff --git a/viin_document/models/workflow.py b/viin_document/models/workflow.py[m
[1mindex 8d0aa1e..71aadb9 100644[m
[1m--- a/viin_document/models/workflow.py[m
[1m+++ b/viin_document/models/workflow.py[m
[36m@@ -114,7 +114,7 @@[m [mclass WorkflowActionRule(models.Model):[m
                     feedback="completed by rule: %s. %s" % (self.name, self.note or '')[m
                 )[m
 [m
[31m-            # tag and facet actions[m
[32m+[m[32m            # tag and cate_tag actions[m
             for tag_action in self.tag_action_ids:[m
                 tag_action.execute_tag_action(document)[m
 [m
[36m@@ -139,22 +139,22 @@[m [mclass WorkflowTagAction(models.Model):[m
         ('remove', "Remove"),[m
     ], default='add', required=True)[m
 [m
[31m-    facet_id = fields.Many2one('viin_document.tag.cate', string="Category")[m
[32m+[m[32m    cate_tag_id = fields.Many2one('viin_document.tag.cate', string="Category")[m
     tag_id = fields.Many2one('viin_document.tag', string="Tag")[m
 [m
     def execute_tag_action(self, document):[m
         if self.action == 'add' and self.tag_id.id:[m
             return document.write({'tag_ids': [(4, self.tag_id.id, False)]})[m
[31m-        elif self.action == 'replace' and self.facet_id.id:[m
[31m-            faceted_tags = self.env['viin_document.tag'].search([('facet_id', '=', self.facet_id.id)])[m
[31m-            if faceted_tags.ids:[m
[31m-                for tag in faceted_tags:[m
[32m+[m[32m        elif self.action == 'replace' and self.cate_tag_id.id:[m
[32m+[m[32m            cate_taged_tags = self.env['viin_document.tag'].search([('cate_tag_id', '=', self.cate_tag_id.id)])[m
[32m+[m[32m            if cate_taged_tags.ids:[m
[32m+[m[32m                for tag in cate_taged_tags:[m
                     document.write({'tag_ids': [(3, tag.id, False)]})[m
             return document.write({'tag_ids': [(4, self.tag_id.id, False)]})[m
         elif self.action == 'remove':[m
             if self.tag_id.id:[m
                 return document.write({'tag_ids': [(3, self.tag_id.id, False)]})[m
[31m-            elif self.facet_id:[m
[31m-                faceted_tags = self.env['viin_document.tag'].search([('facet_id', '=', self.facet_id.id)])[m
[31m-                for tag in faceted_tags:[m
[32m+[m[32m            elif self.cate_tag_id:[m
[32m+[m[32m                cate_taged_tags = self.env['viin_document.tag'].search([('cate_tag_id', '=', self.cate_tag_id.id)])[m
[32m+[m[32m                for tag in cate_taged_tags:[m
                     return document.write({'tag_ids': [(3, tag.id, False)]})[m
[1mdiff --git a/viin_document/tests/test_documents.py b/viin_document/tests/test_documents.py[m
[1mindex b40edd5..033426d 100644[m
[1m--- a/viin_document/tests/test_documents.py[m
[1m+++ b/viin_document/tests/test_documents.py[m
[36m@@ -33,7 +33,7 @@[m [mclass TestCaseDocuments(TransactionCase):[m
             'name': "categ_b",[m
         })[m
         self.tag_b = self.env['viin_document.tag'].create({[m
[31m-            'facet_id': self.tag_category_b.id,[m
[32m+[m[32m            'cate_tag_id': self.tag_category_b.id,[m
             'name': "tag_b",[m
         })[m
         self.tag_category_a = self.env['viin_document.tag.cate'].create({[m
[36m@@ -45,11 +45,11 @@[m [mclass TestCaseDocuments(TransactionCase):[m
             'name': "categ_a_a",[m
         })[m
         self.tag_a_a = self.env['viin_document.tag'].create({[m
[31m-            'facet_id': self.tag_category_a_a.id,[m
[32m+[m[32m            'cate_tag_id': self.tag_category_a_a.id,[m
             'name': "tag_a_a",[m
         })[m
         self.tag_a = self.env['viin_document.tag'].create({[m
[31m-            'facet_id': self.tag_category_a.id,[m
[32m+[m[32m            'cate_tag_id': self.tag_category_a.id,[m
             'name': "tag_a",[m
         })[m
         self.document_gif = self.env['viin_document.document'].create({[m
[36m@@ -76,7 +76,7 @@[m [mclass TestCaseDocuments(TransactionCase):[m
         })[m
         self.tag_action_a = self.env['viin_document.action.tag'].create({[m
             'action': 'add',[m
[31m-            'facet_id': self.tag_category_b.id,[m
[32m+[m[32m            'cate_tag_id': self.tag_category_b.id,[m
             'tag_id': self.tag_b.id,[m
         })[m
         self.worflow_rule = self.env['viin_document.action'].create({[m
[1mdiff --git a/viin_document/tests/test_tags.py b/viin_document/tests/test_tags.py[m
[1mindex 983a44f..6127e45 100644[m
[1m--- a/viin_document/tests/test_tags.py[m
[1m+++ b/viin_document/tests/test_tags.py[m
[36m@@ -7,15 +7,15 @@[m [mclass TestTags(TransactionCase):[m
         marketing_assets = self.ref('viin_document.documents_marketing_assets')[m
         tag = self.env['viin_document.tag'].create({[m
             'name': 'Foo',[m
[31m-            'facet_id': marketing_assets,[m
[32m+[m[32m            'cate_tag_id': marketing_assets,[m
         })[m
[31m-        self.assertEqual(tag.facet_id.id, marketing_assets, 'should have the right facet')[m
[32m+[m[32m        self.assertEqual(tag.cate_tag_id.id, marketing_assets, 'should have the right cate_tag')[m
         self.assertEqual(tag.name, 'Foo', 'should have the right name')[m
         self.assertTrue(tag.sequence > 0, 'should have a non-zero sequence')[m
 [m
     def test_get_tags(self):[m
         folder_id = self.ref('viin_document.documents_marketing_folder')[m
[31m-        facet_assets = self.env['viin_document.tag.cate'].browse(self.ref('viin_document.documents_marketing_assets'))[m
[32m+[m[32m        cate_tag_assets = self.env['viin_document.tag.cate'].browse(self.ref('viin_document.documents_marketing_assets'))[m
         tag_assets_ads = self.env['viin_document.tag'].browse(self.ref('viin_document.documents_marketing_assets_ads'))[m
         tag_assets_videos = self.env['viin_document.tag'].browse(self.ref('viin_document.documents_marketing_assets_Videos'))[m
 [m
[36m@@ -27,9 +27,9 @@[m [mclass TestTags(TransactionCase):[m
         self.assertEqual(len(tags), 4, 'should return a non-empty list of tags')[m
 [m
         first_record = {[m
[31m-            'group_id': facet_assets.id,[m
[31m-            'group_name': facet_assets.name,[m
[31m-            'group_sequence': facet_assets.sequence,[m
[32m+[m[32m            'group_id': cate_tag_assets.id,[m
[32m+[m[32m            'group_name': cate_tag_assets.name,[m
[32m+[m[32m            'group_sequence': cate_tag_assets.sequence,[m
             'group_tooltip': None,[m
             'id': tag_assets_ads.id,[m
             'display_name': tag_assets_ads.name,[m
[36m@@ -40,9 +40,9 @@[m [mclass TestTags(TransactionCase):[m
         self.assertEqual(tags[0], first_record, 'first record should match')[m
 [m
         last_record = {[m
[31m-            'group_id': facet_assets.id,[m
[31m-            'group_name': facet_assets.name,[m
[31m-            'group_sequence': facet_assets.sequence,[m
[32m+[m[32m            'group_id': cate_tag_assets.id,[m
[32m+[m[32m            'group_name': cate_tag_assets.name,[m
[32m+[m[32m            'group_sequence': cate_tag_assets.sequence,[m
             'group_tooltip': None,[m
             'id': tag_assets_videos.id,[m
             'display_name': tag_assets_videos.name,[m
[36m@@ -53,7 +53,7 @@[m [mclass TestTags(TransactionCase):[m
 [m
     def test_get_tags_reordered(self):[m
         folder_id = self.ref('viin_document.documents_marketing_folder')[m
[31m-        facet_assets = self.env['viin_document.tag.cate'].browse(self.ref('viin_document.documents_marketing_assets'))[m
[32m+[m[32m        cate_tag_assets = self.env['viin_document.tag.cate'].browse(self.ref('viin_document.documents_marketing_assets'))[m
         tag_assets_images = self.env['viin_document.tag'].browse(self.ref('viin_document.documents_marketing_assets_images'))[m
         tag_assets_videos = self.env['viin_document.tag'].browse(self.ref('viin_document.documents_marketing_assets_Videos'))[m
 [m
[36m@@ -65,9 +65,9 @@[m [mclass TestTags(TransactionCase):[m
         self.assertEqual(len(tags), 4, 'should return a non-empty list of tags')[m
 [m
         first_record = {[m
[31m-            'group_id': facet_assets.id,[m
[31m-            'group_name': facet_assets.name,[m
[31m-            'group_sequence': facet_assets.sequence,[m
[32m+[m[32m            'group_id': cate_tag_assets.id,[m
[32m+[m[32m            'group_name': cate_tag_assets.name,[m
[32m+[m[32m            'group_sequence': cate_tag_assets.sequence,[m
             'group_tooltip': None,[m
             'id': tag_assets_images.id,[m
             'display_name': tag_assets_images.name,[m
[36m@@ -78,9 +78,9 @@[m [mclass TestTags(TransactionCase):[m
         self.assertEqual(first_tag, first_record, 'first record should match')[m
 [m
         last_record = {[m
[31m-            'group_id': facet_assets.id,[m
[31m-            'group_name': facet_assets.name,[m
[31m-            'group_sequence': facet_assets.sequence,[m
[32m+[m[32m            'group_id': cate_tag_assets.id,[m
[32m+[m[32m            'group_name': cate_tag_assets.name,[m
[32m+[m[32m            'group_sequence': cate_tag_assets.sequence,[m
             'group_tooltip': None,[m
             'id': tag_assets_videos.id,[m
             'display_name': tag_assets_videos.name,[m
[36m@@ -95,7 +95,7 @@[m [mclass TestTags(TransactionCase):[m
             'name': 'Empty Folder',[m
             'parent_folder_id': self.env.ref('viin_document.documents_marketing_folder').id,[m
         }).id[m
[31m-        facet_assets = self.env['viin_document.tag.cate'].browse(self.ref('viin_document.documents_marketing_assets'))[m
[32m+[m[32m        cate_tag_assets = self.env['viin_document.tag.cate'].browse(self.ref('viin_document.documents_marketing_assets'))[m
         tag_assets_ads = self.env['viin_document.tag'].browse(self.ref('viin_document.documents_marketing_assets_ads'))[m
         tag_assets_videos = self.env['viin_document.tag'].browse(self.ref('viin_document.documents_marketing_assets_Videos'))[m
 [m
[36m@@ -106,9 +106,9 @@[m [mclass TestTags(TransactionCase):[m
         self.assertEqual(len(tags), 4, 'should return a non-empty list of tags')[m
 [m
         first_record = {[m
[31m-            'group_id': facet_assets.id,[m
[31m-            'group_name': facet_assets.name,[m
[31m-            'group_sequence': facet_assets.sequence,[m
[32m+[m[32m            'group_id': cate_tag_assets.id,[m
[32m+[m[32m            'group_name': cate_tag_assets.name,[m
[32m+[m[32m            'group_sequence': cate_tag_assets.sequence,[m
             'group_tooltip': None,[m
             'id': tag_assets_ads.id,[m
             'display_name': tag_assets_ads.name,[m
[36m@@ -118,9 +118,9 @@[m [mclass TestTags(TransactionCase):[m
         self.assertEqual(tags[0], first_record, 'first record should match')[m
 [m
         last_record = {[m
[31m-            'group_id': facet_assets.id,[m
[31m-            'group_name': facet_assets.name,[m
[31m-            'group_sequence': facet_assets.sequence,[m
[32m+[m[32m            'group_id': cate_tag_assets.id,[m
[32m+[m[32m            'group_name': cate_tag_assets.name,[m
[32m+[m[32m            'group_sequence': cate_tag_assets.sequence,[m
             'group_tooltip': None,[m
             'id': tag_assets_videos.id,[m
             'display_name': tag_assets_videos.name,[m
[1mdiff --git a/viin_document/views/documents_configs/documents_folder_views.xml b/viin_document/views/documents_configs/documents_folder_views.xml[m
[1mindex f41db39..187fd97 100644[m
[1m--- a/viin_document/views/documents_configs/documents_folder_views.xml[m
[1m+++ b/viin_document/views/documents_configs/documents_folder_views.xml[m
[36m@@ -22,7 +22,7 @@[m
             <tree>[m
                 <field name="sequence" widget="handle"/>[m
                 <field name="display_name" string="Workspace"/>[m
[31m-                <field name="facet_ids"  widget="many2many_tags" string="Tag Categories"/>[m
[32m+[m[32m                <field name="cate_tag_ids"  widget="many2many_tags" string="Tag Categories"/>[m
                 <field name="company_id" groups="base.group_multi_company"/>[m
                 <field name="group_ids" widget="many2many_tags"/>[m
                 <field name="read_group_ids" widget="many2many_tags"/>[m
[36m@@ -64,7 +64,7 @@[m
                     </group>[m
                     <notebook>[m
                         <page string="Tags" name="tags">[m
[31m-                            <field name="facet_ids" context="{[m
[32m+[m[32m                            <field name="cate_tag_ids" context="{[m
                                 'form_view_ref' : 'viin_document.tag_cate_view_form',[m
                                 'documents_view_from_folder' : True,[m
                                 'default_folder_id' : id,[m
[36m@@ -75,8 +75,8 @@[m
                                     <field name="name" string="Category"/>[m
                                     <field name="tag_ids"[m
                                            string="Tags"[m
[31m-                                           domain="[('facet_id', '=' , id)]"[m
[31m-                                           context="{'default_facet_id' : id}"[m
[32m+[m[32m                                           domain="[('cate_tag_id', '=' , id)]"[m
[32m+[m[32m                                           context="{'default_cate_tag_id' : id}"[m
                                            options="{'no_create_edit': True}"[m
                                            widget="many2many_tags"/>[m
                                 </tree>[m
[1mdiff --git a/viin_document/views/documents_configs/vii_document_tag_cate_views.xml b/viin_document/views/documents_configs/vii_document_tag_cate_views.xml[m
[1mindex fe3d5ac..c11271e 100644[m
[1m--- a/viin_document/views/documents_configs/vii_document_tag_cate_views.xml[m
[1m+++ b/viin_document/views/documents_configs/vii_document_tag_cate_views.xml[m
[36m@@ -3,8 +3,8 @@[m
 [m
     <!-- tags categories -->[m
 [m
[31m-    <record id="facet_view_search" model="ir.ui.view">[m
[31m-        <field name="name">facet search</field>[m
[32m+[m[32m    <record id="cate_tag_view_search" model="ir.ui.view">[m
[32m+[m[32m        <field name="name">cate_tag search</field>[m
         <field name="model">viin_document.tag.cate</field>[m
         <field name="arch" type="xml">[m
         <search>[m
[36m@@ -19,7 +19,7 @@[m
     </record>[m
 [m
     <record id="tag_cate_view_form" model="ir.ui.view">[m
[31m-        <field name="name">documents facet form view</field>[m
[32m+[m[32m        <field name="name">documents cate_tag form view</field>[m
         <field name="priority" eval="2"/>[m
         <field name="model">viin_document.tag.cate</field>[m
         <field name="arch" type="xml">[m
[36m@@ -48,7 +48,7 @@[m
 [m
 [m
     <record id="tag_cate_view_form_with_folder" model="ir.ui.view">[m
[31m-        <field name="name">documents facet form view with folder</field>[m
[32m+[m[32m        <field name="name">documents cate_tag form view with folder</field>[m
         <field name="model">viin_document.tag.cate</field>[m
         <field name="priority" eval="1"/>[m
         <field name="mode">primary</field>[m
[36m@@ -62,7 +62,7 @@[m
         </field>[m
     </record>[m
 [m
[31m-    <record id="facet_view_tree" model="ir.ui.view">[m
[32m+[m[32m    <record id="cate_tag_view_tree" model="ir.ui.view">[m
         <field name="name">tag categories tree</field>[m
         <field name="model">viin_document.tag.cate</field>[m
         <field name="arch" type="xml">[m
[36m@@ -74,13 +74,13 @@[m
         </field>[m
     </record>[m
 [m
[31m-    <record id="facet_action" model="ir.actions.act_window">[m
[32m+[m[32m    <record id="cate_tag_action" model="ir.actions.act_window">[m
       <field name="name">Tags</field>[m
       <field name="res_model">viin_document.tag.cate</field>[m
       <field name="context">{'simple_name': True}</field>[m
       <field name="view_mode">tree,form</field>[m
         <field name="view_ids" eval="[(5, 0, 0),[m
[31m-            (0, 0, {'view_mode': 'tree', 'view_id': ref('viin_document.facet_view_tree')}),[m
[32m+[m[32m            (0, 0, {'view_mode': 'tree', 'view_id': ref('viin_document.cate_tag_view_tree')}),[m
             (0, 0, {'view_mode': 'form', 'view_id': ref('viin_document.tag_cate_view_form_with_folder')})]"/>[m
     </record>[m
 [m
[1mdiff --git a/viin_document/views/documents_configs/viin_document_action_views.xml b/viin_document/views/documents_configs/viin_document_action_views.xml[m
[1mindex 87e6f50..0995362 100644[m
[1m--- a/viin_document/views/documents_configs/viin_document_action_views.xml[m
[1m+++ b/viin_document/views/documents_configs/viin_document_action_views.xml[m
[36m@@ -83,7 +83,7 @@[m
                                     <field name="tag_action_ids">[m
                                         <tree editable="bottom">[m
                                             <field name="action"/>[m
[31m-                                            <field name="facet_id"[m
[32m+[m[32m                                            <field name="cate_tag_id"[m
                                                    domain="['|',[m
                                                        ('folder_id','parent_of', parent.folder_id),[m
                                                        ('folder_id', 'parent_of', parent.domain_folder_id)[m
[36m@@ -91,7 +91,7 @@[m
                                                    required="1"/>[m
                                             <field name="tag_id"[m
                                                    context="{'simple_name': True}"[m
[31m-                                                   domain="[('facet_id','=',facet_id)]"[m
[32m+[m[32m                                                   domain="[('cate_tag_id','=',cate_tag_id)]"[m
                                                    options='{"no_open": True}'/>[m
                                         </tree>[m
                                     </field>[m
[36m@@ -131,7 +131,7 @@[m
         <field name="arch" type="xml">[m
             <tree editable="bottom">[m
                 <field name="action"/>[m
[31m-                <field name="facet_id"/>[m
[32m+[m[32m                <field name="cate_tag_id"/>[m
                 <field name="tag_id"/>[m
             </tree>[m
         </field>[m
[36m@@ -148,7 +148,7 @@[m
                             <field name="action"/>[m
                         </group>[m
                         <div>[m
[31m-                            <field class="oe_inline" name="facet_id"/>[m
[32m+[m[32m                            <field class="oe_inline" name="cate_tag_id"/>[m
                             <field class="oe_inline" name="tag_id"/>[m
                         </div>[m
                     </group>[m
[1mdiff --git a/viin_document/views/documents_configs/viin_document_tag_views.xml b/viin_document/views/documents_configs/viin_document_tag_views.xml[m
[1mindex 94e5392..19df00a 100644[m
[1m--- a/viin_document/views/documents_configs/viin_document_tag_views.xml[m
[1m+++ b/viin_document/views/documents_configs/viin_document_tag_views.xml[m
[36m@@ -13,7 +13,7 @@[m
                         <h1><field name="name"/></h1>[m
                     </div>[m
                     <group>[m
[31m-                        <field name="facet_id" string="Category"/>[m
[32m+[m[32m                        <field name="cate_tag_id" string="Category"/>[m
                     </group>[m
                 </sheet>[m
             </form>[m
[36m@@ -26,7 +26,7 @@[m
         <field name="arch" type="xml">[m
         <search>[m
             <field name="name" string="Tag"/>[m
[31m-            <field name="facet_id"/>[m
[32m+[m[32m            <field name="cate_tag_id"/>[m
          </search>[m
         </field>[m
     </record>[m
[1mdiff --git a/viin_document/views/menu.xml b/viin_document/views/menu.xml[m
[1mindex 1468c35..c6a6320 100644[m
[1m--- a/viin_document/views/menu.xml[m
[1m+++ b/viin_document/views/menu.xml[m
[36m@@ -3,11 +3,11 @@[m
 [m
     <menuitem name="Documents" id="viin_document.menu_root" groups="viin_document.viin_document_group_user" web_icon="documents,static/description/icon.png"/>[m
    [m
[31m-    <menuitem name="Documents" id="viin_document.dashboard" parent="viin_document.menu_root" action="document_action" groups="viin_document.viin_document_group_user" sequence="1"/>[m
[32m+[m[32m    <!-- <menuitem name="Documents" id="viin_document.dashboard" parent="viin_document.menu_root" action="document_action" groups="viin_document.viin_document_group_user" sequence="1"/> -->[m
     <!-- Configuration -->[m
     <menuitem name="Configuration" id="viin_document.Config" parent="viin_document.menu_root" sequence="2"/>[m
     <menuitem name="Workspaces" id="viin_document.folder_menu" parent="viin_document.Config" action="folder_action" groups="viin_document.viin_document_group_manager" sequence="1"/>[m
[31m-    <menuitem name="Tags" id="viin_document.category_menu" parent="viin_document.Config" action="facet_action" sequence="2"/>[m
[32m+[m[32m    <menuitem name="Tags" id="viin_document.category_menu" parent="viin_document.Config" action="cate_tag_action" sequence="2"/>[m
     <menuitem name="Actions" id="viin_document.workflow_rules_menu" parent="viin_document.Config" groups="base.group_no_one" action="workflow_rule_action" sequence="3"/>[m
     <menuitem name="Shares &amp; Emails" id="viin_document.share_menu" parent="viin_document.Config" action="share_action" sequence="4"/>[m
 [m
