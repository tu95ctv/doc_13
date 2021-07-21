# -*- coding: utf-8 -*-
{
    'name': "Viindoo Document management",
    'name_vi_VN':'Quản lý tài liệu',
    'summary': "Document management",
    'summary_vi_VN':'Quản lý tài liệu',
    'description': """
        upload, download and manage your documents.
    """,
    'author': "Viindoo",
    'category': 'Productivity/Documents',
    'sequence': 80,
    'version': '0.1.0',
    'installable':True,
    'application': True,
    'auto_install':False,
    'website': 'https://viindoo.com',
    'live_test_url':'',
    'support': 'apps.support@viindoo.com',
    'price': 99.9,
    'currency': 'EUR',
    'license': 'OPL-1',
    'depends': ['base', 'mail', 'portal', 'web', 'attachment_indexation', 'digest','graphql_base'],
    'data': [
        #security
        'security/security.xml',
        'security/ir.model.access.csv',
        #data
        'data/documents_data.xml',
        #view
        'views/documents_views.xml',
        'views/documents_configs/documents_folder_views.xml',
        'views/documents_configs/documents_share_views.xml',
        'views/documents_configs/documents_workflow_rule_views.xml',
        'views/documents_configs/documents_facet_views.xml',
        'views/documents_configs/documents_tag_views.xml',
        'views/menu.xml',
    ],
    'license': 'OEEL-1',
    'external_dependencies': {
        'bin': [
        ],
        'python': [
            'graphene',
        ],
    },

}
