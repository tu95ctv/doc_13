import { TreeSelect, TreeSelectSelectionKeys, TreeSelectSelectionKeysType } from 'primereact/treeselect';
import { useGetAllTagsQuery } from '../../codegen'
import useCurrentFolder from "../../features/currentFolder/useCurrentFolder";
import useCurrentTags from './useCurrentTags';
import React from 'react'
const TagsSelector = () => {
    const { currentFolder } = useCurrentFolder()
    const { setCurrentTags, currentTags } = useCurrentTags()
    const { data, loading } = useGetAllTagsQuery({
        variables: {
            folderId: currentFolder
        }
    })
    const defaultTagsKeys = currentTags.reduce((prev, cur) => {
        return {
            ...prev,
            [cur]: true
        }
    }, {})
    const [selectedKeys, setSelectedKeys] = React.useState<TreeSelectSelectionKeysType>(defaultTagsKeys)

    React.useEffect(() => {
        console.log(selectedKeys)
        const keys = Object.keys(selectedKeys)
        if (keys.length > 0) {
            setCurrentTags(keys)
        }
    }, [selectedKeys])
    if (loading) return <div>...</div>
    const m = data?.allTagCategories.map((item) => {
        return {
            key: item.id,
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
            onChange={e => setSelectedKeys(e.value as TreeSelectSelectionKeysType)} 
            selectionMode="multiple" 
            metaKeySelection={false} 
            placeholder="Select Items"
        />
    )
}

export default TagsSelector
