import React, { useState } from "react";
import "react-dropzone-uploader/dist/styles.css";
import Dropzone from "react-dropzone-uploader";
import { useUploadFilesMutation, useGetAllDocumentsQuery } from './codegen'
import { useAppSelector } from './app/hooks'
import { selectCurrentFolder } from './features/currentFolder/slice'

function toBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      let encoded = reader.result.toString().replace(/^data:(.*,)?/, '');
      if ((encoded.length % 4) > 0) {
        encoded += '='.repeat(4 - (encoded.length % 4));
      }
      resolve(encoded);
    };
    reader.onerror = error => reject(error);
  });
}
const Uploader: React.FC = () => {
  const folderId = useAppSelector(selectCurrentFolder)
  const { refetch } = useGetAllDocumentsQuery({
    variables: { folderId },
  })
  const [mutate, { loading }] = useUploadFilesMutation({
    onCompleted: () => {
      refetch()
    },
    onError: (err) => {
      console.log(err)
    }
  })
  const [img, setImg] = useState("http://placehold.it/180");

  const handleChangeStatus = ({ meta }: any, status: string) => {
    console.log(status, meta);
  };

  // const saveBase64AsFile = (base64, fileName) => {
  //   var link = document.createElement("a");

  //   link.setAttribute("href", base64);
  //   link.setAttribute("download", fileName);
  //   link.click();
  // };

  const handleSubmit = async (files: any[], allFiles: any) => {
    //console.log(files.map((f) => f.meta));
    // console.log("files", files);
    let fileObjects: any[] = []
    let promises: any[] = []
    files.forEach((file: any) => {
      const promise = new Promise((resolve, reject) => {
        toBase64(file.file)
          .then((blob) => {
            fileObjects.push({
              folderId,
              blob,
              name: file.meta.name,
              type: file.meta.type,
            });
            resolve(true);
          })
          .catch(() => reject())
      })
      promises.push(promise)
    })
    
    await Promise.all(promises)
    console.log("fileObjects", fileObjects);
    
    mutate({
      variables: {
        fileObjects
      }
    })
    // allFiles.forEach(f => f.remove());
  };

  return (
    <div>
      <Dropzone
        inputContent={"Upload files or take photos"}
        inputWithFilesContent={"Add more"}
        submitButtonContent={"Save"}
        // getUploadParams={getUploadParams}
        onChangeStatus={handleChangeStatus}
        onSubmit={handleSubmit}
        disabled={loading}
        styles={{ dropzone: { minHeight: 250, maxHeight: 300 } }}
      />
      <img id="blah" src={img} alt="preview" />
    </div>
  );
}

export default Uploader
