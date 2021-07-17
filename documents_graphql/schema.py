# Copyright 2018 ACSONE SA/NV
# License LGPL-3.0 or later (http://www.gnu.org/licenses/lgpl).

# disable undefined variable error, which erroneously triggers
# on forward declarations of classes in lambdas
# pylint: disable=E0602

import graphene

from odoo import _
from odoo.exceptions import UserError
from odoo.api import call_kw
from odoo.addons.graphql_base import OdooObjectType
from graphene.types.generic import GenericScalar
from odoo.http import request

##folder##
class ParentFolder(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String(required=True)

class Folder(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String(required=True)
    parent_folder = graphene.Field(ParentFolder)
    parent_folder_id = graphene.Int()

    @staticmethod
    def resolve_parent_folder(root, info):
        return root.parent_folder_id or None
    
    @staticmethod
    def resolve_parent_folder_id(root, info):
        return root.parent_folder_id.id or None

class Tag(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String(required=True)

class User(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String(required=True)   

##!folder##
###docs###
class Document(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String()
    folder_id = graphene.Field(Folder)
    owner_id = graphene.Field(User)
    partner_id = graphene.Int()
    create_date = graphene.String()
    icon_url = graphene.String()
    tags = graphene.List(
        graphene.NonNull(Tag),
        required=True,
        limit=graphene.Int(),
        offset=graphene.Int(),
    )
    download_url = graphene.String()
    vii_search_count = graphene.Int()

    @staticmethod
    def resolve_download_url(root, info):
        return 'documents/content/%s'%root.id

    @staticmethod
    def resolve_owner_id(root, info, limit=80, offset=None):
        return root.owner_id

    @staticmethod
    def resolve_folder_id(root, info):
        return root.folder_id or None
    
    @staticmethod
    def resolve_tags(root, info, limit=80, offset=None):
        return root.tag_ids
    
class TagCategory(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String(required=True)
    folder_id = graphene.Int()
   
    tags = graphene.List(
        graphene.NonNull(Tag),
        required=True,
        limit=graphene.Int(),
        offset=graphene.Int(),
    )
    @staticmethod
    def resolve_tags(root, info, limit=80, offset=None):
        return info.context["env"]["documents.tag"].search(
            [('facet_id','=', root.id)], limit=limit, offset=offset
        )
    
class Share(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String(required=True)
    full_url = graphene.String()
    action = graphene.String()
    type = graphene.String()
   
###!docs###

class Query(graphene.ObjectType):
    
    all_documents = graphene.List(
        graphene.NonNull(Document),
        required=True,
        id =graphene.Int(),
        domain=GenericScalar(),
        search=graphene.String(),
        folder_id=graphene.Int(),
        tag_ids=graphene.List(graphene.Int),
        companies_only=graphene.Boolean(),
        limit=graphene.Int(),
        offset=graphene.Int(),
    )

    all_folders = graphene.List(
        graphene.NonNull(Folder),
        required=True,
        parent_folder_id=graphene.Int(),
        companies_only=graphene.Boolean(),
        limit=graphene.Int(),
        offset=graphene.Int(),
    )
    
    all_tag_categories = graphene.List(
        graphene.NonNull(TagCategory),
        required=True,
        folder_id=graphene.Int(),
        limit=graphene.Int(),
        offset=graphene.Int(),
    )

    reverse = graphene.String(
        required=True,
        description="Reverse a string",
        word=graphene.String(required=True),
    )

    error_example = graphene.String()
    
    @staticmethod
    def resolve_all_documents(root, info,id=None, limit=80,domain=None, folder_id=None, tag_ids=None,
        search=None,
        offset=None):
        if id:
            return info.context["env"]["documents.document"].browse(id)
        print ('**domain**', domain, type(domain))
        domain_new = []
        if domain:
            domain_new += domain
        if folder_id:
            domain_new +=[('folder_id', 'child_of', folder_id)]
        if tag_ids:
            domain_new +=[('tag_ids', 'in', tag_ids)]
        if search:  
            domain_new +=[('name', 'ilike', search)]
        Doc = info.context["env"]["documents.document"]
        search_count = Doc.search_count(domain_new)
        return Doc.with_context(vii_search_count=search_count).search(
            domain_new, limit=limit, offset=offset
        )

    @staticmethod
    def resolve_all_folders(root, info, parent_folder_id = None, limit=80, offset=None):
        domain = []
        if parent_folder_id:
            domain +=[('parent_folder_id','=', parent_folder_id)]

        return info.context["env"]["documents.folder"].search(
            domain, limit=limit, offset=offset
        )

    @staticmethod
    def resolve_all_tag_categories(root, info, folder_id = None, limit=80, offset=None):
        domain = []
        if folder_id:
            domain +=[('folder_id','=', folder_id)]

        return info.context["env"]["documents.facet"].search(
            domain, limit=limit, offset=offset
        )
 
    @staticmethod
    def resolve_reverse(root, info, word):
        return word[::-1]

    @staticmethod
    def resolve_error_example(root, info):
        raise UserError(_("UserError example"))

##################################MUTATE###################################################

class DocWrite(graphene.Mutation):
    class Arguments:
        id = graphene.List(graphene.Int, required=True)
        name = graphene.String()
        folder_id = graphene.Int()
        tag_ids = graphene.List(graphene.Int)

    Output = Document

    @staticmethod
    def mutate(self, info,id,name=None,tag_ids=None,folder_id=None):
        env = info.context["env"]
        doc = env["documents.document"].browse(id)
        vals = {}
        if name !=None:
            vals['name'] = name
        if tag_ids !=None:
            vals['tag_ids'] = [(6,0,tag_ids)]
        if folder_id !=None:
            vals['folder_id'] = name
        
        doc.write(vals) 
        return doc

class MutateShare(graphene.Mutation):#
    class Arguments:
        id = graphene.List(graphene.Int)
        folder_id = graphene.Int(required=True)
        document_ids = graphene.List(graphene.Int)
        action = graphene.String()#downloadupload
        type = graphene.String()

    Output = Share

    @staticmethod
    def mutate(self, info,id=None,folder_id=None,action=None,type=None, document_ids=None):
        env = info.context["env"]
        doc = env["documents.share"].browse(id)

        vals = {}
        if document_ids !=None:
            vals['document_ids'] = [(6,0,document_ids)]
        vals['folder_id'] = folder_id
        # action = downloadupload
        if action:
            vals['action'] = action
        if type:
            vals['type'] = type


        if not doc:
            doc = doc.create(vals) 
        else:
            doc.write(vals)

        return doc

###uploadM###

class FileInput(graphene.InputObjectType):
    name = graphene.String(required=True)
    # size = graphene.Float(required=True)
    type = graphene.String(required=True)
    blob = graphene.String(required=True)
    folder_id = graphene.Int(required=True)
    tag_ids = graphene.List(graphene.Int)

class UploadDocM(graphene.Mutation):
    class Arguments:
        file_objects = graphene.List(FileInput, required=True)
    Output = Document
   
    @staticmethod
    def mutate(self, info, file_objects):
        env = info.context["env"]
        empty_docs = env["documents.document"]
        for obj in file_objects:
            name = obj['name']
            folder_id = obj['folder_id']
            data = obj['blob']
            file = data.encode("utf-8")
            mimetype = obj['type']
            tag_ids = obj.get('tag_ids',[])
            if tag_ids:
                tag_ids = [(6,0,tag_ids)]
            vals = {
                'mimetype': mimetype,
                'name': name,
                'type': 'binary',
                'datas': file,
                'folder_id':folder_id,
                'tag_ids':tag_ids
            }
            doc = env["documents.document"].create(vals)
            empty_docs = empty_docs|doc
        return doc
###!upload###
####

def _mutate(self, info,id=[],model=None,method=None,args=[], kwargs={}):
    env = info.context["env"]
    args = id + args 
    obj = request.env[model]
    rs = call_kw(request.env[model],method,args,kwargs)
    print ('rs', rs)
    rt = obj.browse(id)[0]
    return rt

class CallKW(graphene.Mutation):
    class Arguments:
        id = graphene.List(graphene.Int)
        args = graphene.List(graphene.Int)
        kwargs = GenericScalar()
        method = graphene.String(required=True)
        model = graphene.String(required=True)

    Output = Document

    @staticmethod
    def mutate(self, info,id=[],model=None,method=None,args=[], kwargs={}):
        rs = _mutate(self, info,id,model,method,args, kwargs)
        return rs

class CallKWDoc(CallKW):
    class Arguments:
        id = graphene.List(graphene.Int)
        method = graphene.String(required=True)
        args = graphene.List(graphene.Int)
        kwargs = GenericScalar()

    Output = Document

    @staticmethod
    def mutate(self, info,id=[],method=None,args=[], kwargs={}):
        model = 'documents.document'
        rs = _mutate(self, info,id,model,method,args, kwargs)
        return rs

class DocToggleActive(CallKWDoc):
    class Arguments:
        id = graphene.List(graphene.Int, required=True)

    @staticmethod
    def mutate(self, info,id=[]):
        model = 'documents.document'
        method = 'toggle_active'
        rs = _mutate(self, info,id,model,method)
        return rs

class ReUpload(CallKW):
    class Arguments:
        id = graphene.List(graphene.Int, required=True)
        name = graphene.String(required=True)
        type = graphene.String(required=True)
        blob = graphene.String(required=True)
    Output = Document

    @staticmethod
    def mutate(self, info,id,name, type, blob):
        vals = {}
        vals['name'] = name
        vals['mimetype'] = type
        file = blob.encode("utf-8")
        vals['datas'] = file
        model = 'documents.document'
        method = 'write'
        args=[vals]
        rs = _mutate(self,info,id,model,method,args)
        return rs

class Mutation(graphene.ObjectType):
    # create_partner = CreatePartner.Field(description="Documentation of CreatePartner")
    upload_doc_m = UploadDocM.Field(description="Documentation of Upload Multiple")
    doc_write = DocWrite.Field(description="Documentation of doc_write")
    share_mutate = MutateShare.Field(description="Documentation of share_mutate")
    call_kw = CallKW.Field(description="Documentation of call_kw")
    call_kw_doc = CallKWDoc.Field(description="Documentation of call_kw")
    doc_toggle_active = DocToggleActive.Field(description="Documentation of doc_toggle_active")
    reupload = ReUpload.Field(description="Documentation of doc_toggle_active")


schema = graphene.Schema(query=Query, mutation=Mutation)
