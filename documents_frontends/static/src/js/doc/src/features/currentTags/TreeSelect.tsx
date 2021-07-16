import { TreeSelect, TreeSelectSelectionKeys, TreeSelectSelectionKeysType } from 'primereact/treeselect';
import { useGetAllTagsQuery } from '../../codegen'
import useCurrentFolder from "../../features/currentFolder/useCurrentFolder";
import useCurrentTags from './useCurrentTags';
import React from 'react'
const TagsSelector = () => {
    const { currentFolder } = useCurrentFolder()
    const { setCurrentTags } = useCurrentTags()
    const { data, loading } = useGetAllTagsQuery({
        variables: {
            folderId: currentFolder
        }
    })
    const [selectedKeys, setSelectedKeys] = React.useState<TreeSelectSelectionKeysType>(null)


    if (loading) return <div>...</div>
    const m = data?.allTagCategories.map((item) => {
        return {
            key: item.key,
            label: item.label,
            data: item.label,
            children: item.children.map((c: any) => {
                c.children = []
                return c
            }),
        }
    }) || null
    return (
        <TreeSelect 
            value={selectedKeys} 
            options={m} 
            onChange={console.log} 
            selectionMode="multiple" 
            metaKeySelection={false} 
            placeholder="Select Items"
        />
    )
}

export default TagsSelector
