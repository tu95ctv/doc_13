# Copyright 2018 ACSONE SA/NV
# License LGPL-3.0 or later (http://www.gnu.org/licenses/lgpl).

# disable undefined variable error, which erroneously triggers
# on forward declarations of classes in lambdas
# pylint: disable=E0602

import graphene

from odoo import _
from odoo.exceptions import UserError

from odoo.addons.graphql_base import OdooObjectType
from graphene.types.generic import GenericScalar


# class Country(OdooObjectType):
#     code = graphene.String(required=True)
#     name = graphene.String(required=True)


# class Partner(OdooObjectType):
#     name = graphene.String(required=True)
#     street = graphene.String()
#     street2 = graphene.String()
#     city = graphene.String()
#     zip = graphene.String()
#     country = graphene.Field(Country)
#     email = graphene.String()
#     phone = graphene.String()
#     is_company = graphene.Boolean(required=True)
#     contacts = graphene.List(graphene.NonNull(lambda: Partner), required=True)

#     @staticmethod
#     def resolve_country(root, info):
#         return root.country_id or None

#     @staticmethod
#     def resolve_contacts(root, info):
#         return root.child_ids


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

##!folder##
###docs###
class Document(OdooObjectType):
    id = graphene.Int(required=True)
    name = graphene.String()
    folder_id = graphene.Field(Folder)

    @staticmethod
    def resolve_folder_id(root, info):
        return root.folder_id or None

###!docs###
class Query(graphene.ObjectType):
    
    # all_partners = graphene.List(
    #     graphene.NonNull(Partner),
    #     required=True,
    #     companies_only=graphene.Boolean(),
    #     limit=graphene.Int(),
    #     offset=graphene.Int(),
    # )

    all_documents = graphene.List(
        graphene.NonNull(Document),
        required=True,
        domain=GenericScalar(),
        folder_id=graphene.Int(),
        tag_ids=graphene.List(graphene.Int),
        companies_only=graphene.Boolean(),
        folder_id=graphene.Int(),
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

    reverse = graphene.String(
        required=True,
        description="Reverse a string",
        word=graphene.String(required=True),
    )

    error_example = graphene.String()
    #tu them
    @staticmethod
    def resolve_all_documents(root, info, domain=None,folder_id=None, tag_ids=None, offset=None,limit=80):
        domain_new = []
        if domain:
            domain_new += domain
        if folder_id:
            domain_new +=[('folder_id', '=', folder_id)]
        if tag_ids:
            domain_new +=[('tag_ids', '=', tag_ids)]
        return info.context["env"]["documents.document"].search(
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

    #!tu them
    # @staticmethod
    # def resolve_all_partners(root, info, companies_only=False, limit=None, offset=None):
    #     domain = []
    #     if companies_only:
    #         domain.append(("is_company", "=", True))
    #     return info.context["env"]["res.partner"].search(
    #         domain, limit=limit, offset=offset
    #     )

    @staticmethod
    def resolve_reverse(root, info, word):
        return word[::-1]

    @staticmethod
    def resolve_error_example(root, info):
        raise UserError(_("UserError example"))


# class CreatePartner(graphene.Mutation):
#     class Arguments:
#         name = graphene.String(required=True)
#         email = graphene.String(required=True)
#         is_company = graphene.Boolean()
#         raise_after_create = graphene.Boolean()

#     Output = Partner

#     @staticmethod
#     def mutate(self, info, name, email, is_company=False, raise_after_create=False):
#         env = info.context["env"]
#         partner = env["res.partner"].create(
#             {"name": name, "email": email, "is_company": is_company}
#         )
#         if raise_after_create:
#             raise UserError(_("as requested"))
#         return partner

###uploadM###

class FileInput(graphene.InputObjectType):
    name = graphene.String(required=True)
    # size = graphene.Float(required=True)
    type = graphene.String(required=True)
    blob = graphene.String(required=True)
    folder_id = graphene.Int(required=True)

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
            print ('**folder_id**', folder_id)
            data = obj['blob']
            file = data.encode("utf-8")
            mimetype = obj['type']
            vals = {
                'mimetype': mimetype,
                'name': name,
                'type': 'binary',
                'datas': file,
                'folder_id':folder_id
            }
            doc = env["documents.document"].create(vals)
            empty_docs = empty_docs|doc
        return doc
###!upload###



class Mutation(graphene.ObjectType):
    # create_partner = CreatePartner.Field(description="Documentation of CreatePartner")
    upload_doc_m = UploadDocM.Field(description="Documentation of Upload Multiple")

schema = graphene.Schema(query=Query, mutation=Mutation)
