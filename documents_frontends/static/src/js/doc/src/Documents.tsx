// import { useGetAllDocumentsQuery } from "~codegen";
import React from "react";
import { useGetAllDocumentsQuery } from "./codegen";
type DocumentsProps = {
    folderId?: number
}
const Documents: React.FC<DocumentsProps> = ({
    folderId
}) => {
    const { data, loading, refetch } = useGetAllDocumentsQuery({
        variables: { folderId },        
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
