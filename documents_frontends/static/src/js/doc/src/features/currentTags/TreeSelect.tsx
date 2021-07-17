import { TreeSelect, TreeSelectSelectionKeysType } from 'primereact/treeselect';
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

    if (loading) return <div>...</div>
    const m = data?.allTagCategories.map((item) => {
        return {
            key: `category-${item.id}`,
            label: item.label,
            data: item.label,
            type: 'category',
            children: item.children.map((c: any) => {
                c.children = []
                return c
            }),
        }
    }) || null
    return (
        <TreeSelect 
            value={defaultTagsKeys} 
            options={m} 
            onChange={e => {
                const keys = Object.keys(e.value)
                const selected = keys.filter((v) => !v.includes('category'))
                setCurrentTags(selected)
            }} 
            selectionMode="multiple" 
            metaKeySelection={false} 
            placeholder={'Chọn tags'}
        />
    )
}

export default TagsSelector
