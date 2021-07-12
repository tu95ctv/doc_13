import { RootState, AppThunk } from 'app/store';
import { createSlice, PayloadAction } from '@reduxjs/toolkit';
export interface CurrentFolderState {
    value: number | null;
}
  
const initialState: CurrentFolderState = {
    value: null,
};

export const currentFolderSlice = createSlice({
    name: 'currentFolder',
    initialState,
    // The `reducers` field lets us define reducers and generate associated actions
    reducers: {
      setCurrentFolder: (state, action: PayloadAction<number>) => {
        // Redux Toolkit allows us to write "mutating" logic in reducers. It
        // doesn't actually mutate the state because it uses the Immer library,
        // which detects changes to a "draft state" and produces a brand new
        // immutable state based off those changes
        state.value = action.payload;
      },
    },
});
  
export const { setCurrentFolder } = currentFolderSlice.actions;
/*
export const incrementIfOdd = (amount: number): AppThunk => (
    dispatch,
    getState
  ) => {
    const currentValue = selectCount(getState());
    if (currentValue % 2 === 1) {
      dispatch(incrementByAmount(amount));
    }
  };
*/
export const selectCurrentFolder = (state: RootState) => state.currentFolder.value;
export default currentFolderSlice.reducer;
