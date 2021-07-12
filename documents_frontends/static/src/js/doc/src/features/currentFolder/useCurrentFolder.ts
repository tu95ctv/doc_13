import React from 'react'
import { useAppSelector, useAppDispatch } from '../../app/hooks'
import { selectCurrentFolder, setCurrentFolder } from './slice'

const useCurrentFolder = () => {
    const dispatch = useAppDispatch()
    const currentFolder = useAppSelector(selectCurrentFolder)

    const _setCurrentFolder = (folderId: number) => {
        dispatch(setCurrentFolder(folderId))
    }

    return { currentFolder, setCurrentFolder: _setCurrentFolder }
}

export default useCurrentFolder
