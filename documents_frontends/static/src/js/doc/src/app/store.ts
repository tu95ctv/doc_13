import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import currentFolderReducer from '../features/currentFolder/slice';

export const store = configureStore({
  reducer: {
    currentFolder: currentFolderReducer,
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