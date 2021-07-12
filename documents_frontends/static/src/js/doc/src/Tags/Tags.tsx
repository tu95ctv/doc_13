import React from "react";
import DropdownTreeSelect from "react-dropdown-tree-select";
import data from "./data.json";
import 'react-dropdown-tree-select/dist/styles.css'

const onChange = (currentNode: any, selectedNodes: any) => {
  console.log("path::", currentNode.path);
};

const assignObjectPaths = (obj: any, stack: any) => {
  Object.keys(obj).forEach(k => {
    const node = obj[k as any];
    if (typeof node === "object") {
      node.path = stack ? `${stack}.${k}` : k;
      assignObjectPaths(node, node.path);
    }
  });
};

const OrganizationSelector = () => {
  assignObjectPaths(data, null);

  return (
    <DropdownTreeSelect
      showPartiallySelected={false}
      inlineSearchInput={false}
      data={data}
      onChange={onChange}
      className="bootstrap-demo"
    />
  );
};

export default OrganizationSelector
