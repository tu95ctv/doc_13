import React, { useState } from 'react';
import { Dialog } from 'primereact/dialog';
import { Button } from 'primereact/button';
import Uploader from './Uploader';
import './Modal.css';

type DialogDemoProps = {
    folderId: number
}
const DialogDemo: React.FC<DialogDemoProps> = ({ folderId }) => {
    const [displayMaximizable, setDisplayMaximizable] = useState(false);

    const dialogFuncMap: any = {
        'displayMaximizable': setDisplayMaximizable,
    }

    const onClick = (name: string, position?: React.SetStateAction<string> | undefined) => {
        dialogFuncMap[`${name}`](true);

        if (position) {
            setPosition(position);
        }
    }

    const onHide = (name: string) => {
        dialogFuncMap[`${name}`](false);
    }

    const renderFooter = (name: string) => {
        return (
            <div>
                <Button label="No" icon="pi pi-times" onClick={() => onHide(name)} className="p-button-text" />
                <Button label="Yes" icon="pi pi-check" onClick={() => onHide(name)} autoFocus />
            </div>
        );
    }

    return (
        <>
            <Button label="Upload" icon="pi pi-external-link" onClick={() => onClick('displayMaximizable')} />
            <Dialog header="Header" visible={displayMaximizable} maximizable modal style={{ width: '50vw' }} footer={renderFooter('displayMaximizable')} onHide={() => onHide('displayMaximizable')}>
                <Uploader folderId={folderId} />
            </Dialog>
        </>
    )
}

export default DialogDemo
function setPosition(position: React.SetStateAction<string>) {
    throw new Error('Function not implemented.');
}

