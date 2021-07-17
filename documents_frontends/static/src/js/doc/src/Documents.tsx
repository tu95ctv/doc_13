// import { useGetAllDocumentsQuery } from "~codegen";
import React from "react";
import { useGetAllDocumentsQuery } from "./codegen";
import useCurrentFolder from "./features/currentFolder/useCurrentFolder";
import useCurrentTags from "./features/currentTags/useCurrentTags";
import { Tag } from 'primereact/tag';
import { Chip } from 'primereact/chip';

const Documents: React.FC = () => {
    const { currentFolder: folderId } = useCurrentFolder()
    const { currentTags } = useCurrentTags()
    const tagIds = currentTags.map(tag => parseInt(tag))
    const { data, loading, refetch } = useGetAllDocumentsQuery({
        variables: { folderId, tagIds },        
    })

    if (loading) return <div>...</div>

    const cards = data?.allDocuments.map((item) => {
        const tagsNodes = item.tags.map((tag) => {
            return (
                <Tag key={tag.id} value={tag.name} className="p-mr-2"></Tag>
            )
        })
        return (
            <div key={item.id} className="p-col-4 p-card">
            <div style={{ height: "150px" }}>
                <Chip label={item.folderId.name} />
                <h4>{item.name}</h4>
                {tagsNodes}
            </div>
            </div>
        )
    })
    return (
        <div>
<div className="p-grid">
    {cards}
</div>
        </div>
    )
}

export default Documents
