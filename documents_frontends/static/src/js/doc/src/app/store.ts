import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import currentFolderReducer from '../features/currentFolder/slice';
import currentTagsReducer from '../features/currentTags/slice';

export const store = configureStore({
  reducer: {
    currentFolder: currentFolderReducer,
    currentTags: currentTagsReducer,
  },
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;