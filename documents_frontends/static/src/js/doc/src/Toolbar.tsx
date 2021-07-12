import React from 'react';
import { Toolbar } from 'primereact/toolbar';
import { Button } from 'primereact/button';
import Modal from './Modal'
import SearchButton from './Toolbar/SearchButton';
import Tags from './Tags/Tags'
type ToolbarDemoProps = {
    folderId: number
}
const ToolbarDemo: React.FC<ToolbarDemoProps> = ({ folderId }) => {
    const items = [
        {
            label: 'Update',
            icon: 'pi pi-refresh'
        },
        {
            label: 'Delete',
            icon: 'pi pi-times'
        },
        {
            label: 'React Website',
            icon: 'pi pi-external-link',
            command: () => {
                window.location.href = 'https://reactjs.org/'
            }
        },
        {   label: 'Upload',
            icon: 'pi pi-upload',
            command: () => {
                window.location.hash = "/fileupload"
            }
        }
    ];

    const leftContents = (
        <React.Fragment>
            <Button label="New" icon="pi pi-plus" className="p-mr-2" />
            <Modal folderId={folderId} />
            <i className="pi p-toolbar-separator p-mr-2" />
            <Tags />
        </React.Fragment>
    );

    const rightContents = (
        <React.Fragment>
            <SearchButton />
            <Button icon="pi pi-times" className="p-button-danger" />
        </React.Fragment>
    );

    return (
        <div>
            <Toolbar left={leftContents} right={rightContents} />
        </div>
    );
}

export default ToolbarDemo
