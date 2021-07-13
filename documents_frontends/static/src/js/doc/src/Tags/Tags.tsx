import React from "react";
import DropdownTreeSelect from "react-dropdown-tree-select";
import 'react-dropdown-tree-select/dist/styles.css'
import { useGetAllTagsQuery } from '../codegen'
import useCurrentFolder from "../features/currentFolder/useCurrentFolder";

const onChange = (currentNode: any, selectedNodes: any) => {
  console.log("path::", currentNode.path);
};

const assignObjectPaths = (obj: any, stack?: any) => {
  Object.keys(obj).forEach(k => {
    const node = obj[k as any];
    if (typeof node === "object") {
      node.path = stack ? `${stack}.${k}` : k;
      assignObjectPaths(node, node.path);
    }
  });
};

const OrganizationSelector = () => {
  const { currentFolder } = useCurrentFolder()
  const { data, loading } = useGetAllTagsQuery({
    variables: {
      folderId: currentFolder
    }
  })
  if (loading) return <div>...</div>
  const m = data?.allTagCategories.map((item) => {
    return {
      label: item.label,
      value: false,
      children: item.children,
    }
  }) || null
  if (m) {
    //assignObjectPaths(data?.allTagCategories);
    return (
      <DropdownTreeSelect
        showPartiallySelected={false}
        inlineSearchInput={false}
        data={m}
        onChange={onChange}
        className="bootstrap-demo"
      />
    );
  } else {
    return null
  }
};

export default OrganizationSelector
