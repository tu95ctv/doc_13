# Copyright 2018 ACSONE SA/NV
# License LGPL-3.0 or later (http://www.gnu.org/licenses/lgpl).

# disable undefined variable error, which erroneously triggers
# on forward declarations of classes in lambdas
# pylint: disable=E0602

import graphene

from odoo import _
from odoo.exceptions import UserError

from odoo.addons.graphql_base import OdooObjectType


class Country(OdooObjectType):
    code = graphene.String(required=True)
    name = graphene.String(required=True)


class Partner(OdooObjectType):
    name = graphene.String(required=True)
    street = graphene.String()
    street2 = graphene.String()
    city = graphene.String()
    zip = graphene.String()
    country = graphene.Field(Country)
    email = graphene.String()
    phone = graphene.String()
    is_company = graphene.Boolean(required=True)
    contacts = graphene.List(graphene.NonNull(lambda: Partner), required=True)

    @staticmethod
    def resolve_country(root, info):
        return root.country_id or None

    @staticmethod
    def resolve_contacts(root, info):
        return root.child_ids

###docs###
class Document(OdooObjectType):
    name = graphene.String(required=True)
    # street = graphene.String()
    # street2 = graphene.String()
    # city = graphene.String()
    # zip = graphene.String()
    # country = graphene.Field(Country)
    # email = graphene.String()
    # phone = graphene.String()
    # is_company = graphene.Boolean(required=True)
    # contacts = graphene.List(graphene.NonNull(lambda: Partner), required=True)

    # @staticmethod
    # def resolve_country(root, info):
    #     return root.country_id or None

    # @staticmethod
    # def resolve_contacts(root, info):
    #     return root.child_ids
###!docs###
class Query(graphene.ObjectType):
    all_partners = graphene.List(
        graphene.NonNull(Partner),
        required=True,
        companies_only=graphene.Boolean(),
        limit=graphene.Int(),
        offset=graphene.Int(),
    )

    all_docs = graphene.List(
        graphene.NonNull(Document),
        required=True,
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
    def resolve_all_docs(root, info, companies_only=False, limit=None, offset=None):
        domain = []
        if companies_only:
            domain.append(("is_company", "=", True))
        return info.context["env"]["documents.document"].search(
            domain, limit=limit, offset=offset
        )

    #!tu them
    @staticmethod
    def resolve_all_partners(root, info, companies_only=False, limit=None, offset=None):
        domain = []
        if companies_only:
            domain.append(("is_company", "=", True))
        return info.context["env"]["res.partner"].search(
            domain, limit=limit, offset=offset
        )


    @staticmethod
    def resolve_reverse(root, info, word):
        return word[::-1]

    @staticmethod
    def resolve_error_example(root, info):
        raise UserError(_("UserError example"))


class CreatePartner(graphene.Mutation):
    class Arguments:
        name = graphene.String(required=True)
        email = graphene.String(required=True)
        is_company = graphene.Boolean()
        raise_after_create = graphene.Boolean()

    Output = Partner

    @staticmethod
    def mutate(self, info, name, email, is_company=False, raise_after_create=False):
        env = info.context["env"]
        partner = env["res.partner"].create(
            {"name": name, "email": email, "is_company": is_company}
        )
        if raise_after_create:
            raise UserError(_("as requested"))
        return partner

# class Folder(OdooObjectType):
#     name = graphene.String(required=True)

class CreateDoc(graphene.Mutation):
    class Arguments:
        name = graphene.String(required=True)
        folder_id = graphene.Int(required=True)
        line_ids = graphene.JSONString()
        # folder_id = graphene.Field(Folder)
        # email = graphene.String(required=True)
        # is_company = graphene.Boolean()
        # raise_after_create = graphene.Boolean()

    Output = Document

    @staticmethod
    def resolve_folder_id(root, info):
        return root.folder_id or None

    @staticmethod
    def mutate(self, info, name, folder_id,line_ids=False, raise_after_create=False):
        print ('(***line_ids**', line_ids)
        env = info.context["env"]
        doc = env["documents.document"].create(
            {"name": name,
            "folder_id":folder_id,
             }
        )
        if raise_after_create:
            raise UserError(_("as requested"))
        return doc

###upload###
class UploadDoc(graphene.Mutation):
    class Arguments:
        requestFile = graphene.String(required=True)
        folder_id = graphene.Int(required=True)
        # line_ids = graphene.JSONString()
        # folder_id = graphene.Field(Folder)
        # email = graphene.String(required=True)
        # is_company = graphene.Boolean()
        # raise_after_create = graphene.Boolean()

    Output = Document
    # @staticmethod
    # def resolve_folder_id(root, info):
    #     return root.folder_id or None

    @staticmethod
    def mutate(self, info, requestFile, folder_id, raise_after_create=False):
        env = info.context["env"]
        ##
        # requestFile = kwargs['requestFile']
        requestFile = requestFile.split(';base64,',1)
        data = requestFile[1]
        file = data.encode("utf-8")
        mimetype = requestFile[0].split(':')[1]
        ###

        vals = {
            'mimetype': mimetype,
            'name': mimetype,
            'type': 'binary',
            # 'datas': base64.b64encode(data),#cooe gốc
            'datas': file,
            'folder_id':folder_id
        }
        doc = env["documents.document"].with_user(1).create(vals)
        # doc = env["documents.document"].create(
        #     {"name": name,
        #     "folder_id":folder_id,
        #      }
        # )

        if raise_after_create:
            raise UserError(_("as requested"))
        return doc


class Mutation(graphene.ObjectType):
    create_partner = CreatePartner.Field(description="Documentation of CreatePartner")
    create_doc = CreateDoc.Field(description="Documentation of Document")
    upload_doc = UploadDoc.Field(description="Documentation of Upload")


schema = graphene.Schema(query=Query, mutation=Mutation)
