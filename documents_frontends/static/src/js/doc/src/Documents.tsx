// import { useGetAllDocumentsQuery } from "~codegen";
import React from "react";
import { useGetAllDocumentsQuery } from "./codegen";
import useCurrentFolder from "./features/currentFolder/useCurrentFolder";
import useCurrentTags from "./features/currentTags/useCurrentTags";
const Documents: React.FC = () => {
    const { currentFolder: folderId } = useCurrentFolder()
    const { currentTags } = useCurrentTags()
    const tagIds = currentTags.map(tag => parseInt(tag))
    const { data, loading, refetch } = useGetAllDocumentsQuery({
        variables: { folderId, tagIds },        
    })

    if (loading) return <div>...</div>

    const cards = data?.allDocuments.map((item) => {
        return (
            <div key={item.id} className="p-col-4">
            <div className="p-card" style={{ height: "100px" }}>
{item.name}
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
