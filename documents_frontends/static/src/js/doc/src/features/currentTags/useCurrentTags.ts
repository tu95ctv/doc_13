import { useAppSelector, useAppDispatch } from '../../app/hooks'
import { selectCurrentTags, setCurrentTags } from './slice'

const useCurrentTags = () => {
    const dispatch = useAppDispatch()
    const currentTags = useAppSelector(selectCurrentTags)

    const _setCurrentTags = (tags: string[]) => {
        dispatch(setCurrentTags(tags))
    }

    return { currentTags, setCurrentTags: _setCurrentTags }
}

export default useCurrentTags

