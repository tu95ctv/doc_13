import { RootState } from '../../app/store';
import { createSlice, PayloadAction } from '@reduxjs/toolkit';
export interface CurrentTagsState {
    value: number[];
}
  
const initialState: CurrentTagsState = {
    value: [],
};

export const currentTagsSlice = createSlice({
    name: 'currentTags',
    initialState,
    // The `reducers` field lets us define reducers and generate associated actions
    reducers: {
      setCurrentTags: (state, action: PayloadAction<number[]>) => {
        // Redux Toolkit allows us to write "mutating" logic in reducers. It
        // doesn't actually mutate the state because it uses the Immer library,
        // which detects changes to a "draft state" and produces a brand new
        // immutable state based off those changes
        state.value = action.payload;
      },
    },
});
  
export const { setCurrentTags } = currentTagsSlice.actions;
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
export const selectCurrentTags = (state: RootState) => state.currentTags.value;
export default currentTagsSlice.reducer;
