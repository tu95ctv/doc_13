import React, { useEffect } from 'react';
import { Tree } from 'primereact/tree';
import Toolbar from './Toolbar'
import { useGetAllFoldersLazyQuery } from './codegen'
import listToTree from './listToTree';
import Documents from './Documents';

const TreeLazyDemo = () => {
    const [createLazyNodes, { loading, data }] = useGetAllFoldersLazyQuery()
    const [folderId, setFolderId] = React.useState<number>()

    useEffect(() => {
        createLazyNodes()   
    }, []); // eslint-disable-line react-hooks/exhaustive-deps

    const onClick = (node: any) => (e: any) => {
        console.log('id', node)
        setFolderId(node.id)
    }

    const nodeTemplate = (node: any, options: { className: string | undefined; }) => {
        return (
            <span onClick={onClick(node)} className={options.className}>
                {folderId === node.id ? <strong>{node.label}</strong> : node.label}
            </span>
        )
    }

    const nodes = listToTree(data?.allFolders.map((it) => ({
        ...it,
        parent_id: it.parentFolderId,        
    } as any)))
    
    return (
        <div className="p-grid">
            <div className="p-col-3">
            <div className="card">
                <Tree value={nodes} loading={loading} nodeTemplate={nodeTemplate} />
            </div>
            </div>
            <div className="p-col-9">
                {folderId && <Toolbar folderId={folderId} />}
                <Documents folderId={folderId} />
            </div>
        </div>    
    )
}
export default TreeLazyDemo
