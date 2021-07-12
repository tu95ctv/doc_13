import React, { useState, useEffect } from 'react';
import { Tree } from 'primereact/tree';
import Toolbar from './Toolbar'
import { useGetAllFoldersLazyQuery } from './codegen'
import listToTree from './listToTree';
import Documents from './Documents';
const TreeLazyDemo = () => {
    const [createLazyNodes, { loading, data }] = useGetAllFoldersLazyQuery()
    const [folderId, setFolderId] = React.useState<number>()
    // const [nodes, setNodes] = useState<any>(null);
    
    /*
    const createLazyNodes = () => {
        return [
            {
                key: '0',
                label: 'Node 0',
                leaf: false
            },
            {
                key: '1',
                label: 'Node 1',
                leaf: false
            },
            {
                key: '2',
                label: 'Node 2',
                leaf: false
            }
        ];
    }
    */
    /*
    const loadOnExpand = async (event: any) => {
        if (!event.node.children) {
            const nodes = await createLazyNodes()
            let node = { ...event.node };
            node.children = [];

            for (let i = 0; i < 3; i++) {
                node.children.push({
                    key: node.key + '-' + i,
                    label: 'Lazy ' + node.label + '-' + i
                });
            }

            let value = [...nodes];
            value[parseInt(event.node.key, 10)] = node;
            setNodes(value);
        }
    }
    */

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
            <div className="p-col-4">
            <div className="card">
                <Tree value={nodes} loading={loading} nodeTemplate={nodeTemplate} />
            </div>
            </div>
            <div className="p-col-8">
                <Toolbar />
                <Documents folderId={folderId} />
            </div>
        </div>
    
    )
}
export default TreeLazyDemo
