import React, { useEffect } from 'react';
import { Tree } from 'primereact/tree';
import Toolbar from './Toolbar'
import { useGetAllFoldersLazyQuery } from './codegen'
import listToTree from './listToTree';
import Documents from './Documents';

import useCurrentFolder from './features/currentFolder/useCurrentFolder'

const TreeLazyDemo = () => {
    const  { currentFolder: folderId, setCurrentFolder } = useCurrentFolder()
    const [createLazyNodes, { loading, data }] = useGetAllFoldersLazyQuery()

    useEffect(() => {
        createLazyNodes()   
    }, []); // eslint-disable-line react-hooks/exhaustive-deps

    const onClick = (node: any) => (e: any) => {
        console.log('id', node)
        // setFolderId(node.id)
        setCurrentFolder(node.id)
    }

    const nodeTemplate = (node: any, options: { className: string | undefined; }) => {
        return (
            <span onClick={onClick(node)} className={options.className}>
                {folderId === node.id ? <strong>{node.label}</strong> : node.label}
            </span>
        )
    }

    const treeData = [{
        id: null,
        name: 'All',
        label: 'All',
        parentFolderId: null,
    }, ...data?.allFolders as any]

    const nodes = listToTree(treeData.map((it) => ({
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
                <Toolbar />
                <Documents />
            </div>
        </div>    
    )
}
export default TreeLazyDemo
