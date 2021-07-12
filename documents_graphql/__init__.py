from . import controllers
from .schema import schema
import json
introspection_dict = schema.introspect()

with open('schema.json', 'w') as f:
    json.dump(introspection_dict, f)
