import { gql } from '@apollo/client';
import * as Apollo from '@apollo/client';
export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
const defaultOptions =  {}
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  /**
   * The `GenericScalar` scalar type represents a generic
   * GraphQL scalar value that could be:
   * String, Boolean, Int, Float, List or Object.
   */
  GenericScalar: any;
};

export type Document = {
  __typename?: 'Document';
  id: Scalars['Int'];
  name?: Maybe<Scalars['String']>;
  folderId?: Maybe<Folder>;
};

export type FileInput = {
  name: Scalars['String'];
  type: Scalars['String'];
  blob: Scalars['String'];
  folderId: Scalars['Int'];
};

export type Folder = {
  __typename?: 'Folder';
  id: Scalars['Int'];
  name: Scalars['String'];
  parentFolder?: Maybe<ParentFolder>;
  parentFolderId?: Maybe<Scalars['Int']>;
};


export type Mutation = {
  __typename?: 'Mutation';
  /** Documentation of Upload Multiple */
  uploadDocM?: Maybe<Document>;
};


export type MutationUploadDocMArgs = {
  fileObjects: Array<Maybe<FileInput>>;
};

export type ParentFolder = {
  __typename?: 'ParentFolder';
  id: Scalars['Int'];
  name: Scalars['String'];
};

export type Query = {
  __typename?: 'Query';
  allDocuments: Array<Document>;
  allFolders: Array<Folder>;
  /** Reverse a string */
  reverse: Scalars['String'];
  errorExample?: Maybe<Scalars['String']>;
};


export type QueryAllDocumentsArgs = {
  domain?: Maybe<Scalars['GenericScalar']>;
  search?: Maybe<Scalars['String']>;
  folderId?: Maybe<Scalars['Int']>;
  tagIds?: Maybe<Array<Maybe<Scalars['Int']>>>;
  companiesOnly?: Maybe<Scalars['Boolean']>;
  limit?: Maybe<Scalars['Int']>;
  offset?: Maybe<Scalars['Int']>;
};


export type QueryAllFoldersArgs = {
  parentFolderId?: Maybe<Scalars['Int']>;
  companiesOnly?: Maybe<Scalars['Boolean']>;
  limit?: Maybe<Scalars['Int']>;
  offset?: Maybe<Scalars['Int']>;
};


export type QueryReverseArgs = {
  word: Scalars['String'];
};

export type UploadFilesMutationVariables = Exact<{
  fileObjects: Array<Maybe<FileInput>> | Maybe<FileInput>;
}>;


export type UploadFilesMutation = (
  { __typename?: 'Mutation' }
  & { uploadDocM?: Maybe<(
    { __typename?: 'Document' }
    & Pick<Document, 'id' | 'name'>
  )> }
);

export type GetAllDocumentsQueryVariables = Exact<{
  folderId?: Maybe<Scalars['Int']>;
}>;


export type GetAllDocumentsQuery = (
  { __typename?: 'Query' }
  & { allDocuments: Array<(
    { __typename?: 'Document' }
    & Pick<Document, 'id' | 'name'>
  )> }
);

export type GetAllFoldersQueryVariables = Exact<{ [key: string]: never; }>;


export type GetAllFoldersQuery = (
  { __typename?: 'Query' }
  & { allFolders: Array<(
    { __typename?: 'Folder' }
    & Pick<Folder, 'id' | 'name' | 'parentFolderId'>
    & { key: Folder['id'], label: Folder['name'] }
  )> }
);


export const UploadFilesDocument = gql`
    mutation uploadFiles($fileObjects: [FileInput]!) {
  uploadDocM(fileObjects: $fileObjects) {
    id
    name
  }
}
    `;
export type UploadFilesMutationFn = Apollo.MutationFunction<UploadFilesMutation, UploadFilesMutationVariables>;

/**
 * __useUploadFilesMutation__
 *
 * To run a mutation, you first call `useUploadFilesMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUploadFilesMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [uploadFilesMutation, { data, loading, error }] = useUploadFilesMutation({
 *   variables: {
 *      fileObjects: // value for 'fileObjects'
 *   },
 * });
 */
export function useUploadFilesMutation(baseOptions?: Apollo.MutationHookOptions<UploadFilesMutation, UploadFilesMutationVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useMutation<UploadFilesMutation, UploadFilesMutationVariables>(UploadFilesDocument, options);
      }
export type UploadFilesMutationHookResult = ReturnType<typeof useUploadFilesMutation>;
export type UploadFilesMutationResult = Apollo.MutationResult<UploadFilesMutation>;
export type UploadFilesMutationOptions = Apollo.BaseMutationOptions<UploadFilesMutation, UploadFilesMutationVariables>;
export const GetAllDocumentsDocument = gql`
    query getAllDocuments($folderId: Int) {
  allDocuments(folderId: $folderId) {
    id
    name
  }
}
    `;

/**
 * __useGetAllDocumentsQuery__
 *
 * To run a query within a React component, call `useGetAllDocumentsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetAllDocumentsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetAllDocumentsQuery({
 *   variables: {
 *      folderId: // value for 'folderId'
 *   },
 * });
 */
export function useGetAllDocumentsQuery(baseOptions?: Apollo.QueryHookOptions<GetAllDocumentsQuery, GetAllDocumentsQueryVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetAllDocumentsQuery, GetAllDocumentsQueryVariables>(GetAllDocumentsDocument, options);
      }
export function useGetAllDocumentsLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetAllDocumentsQuery, GetAllDocumentsQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetAllDocumentsQuery, GetAllDocumentsQueryVariables>(GetAllDocumentsDocument, options);
        }
export type GetAllDocumentsQueryHookResult = ReturnType<typeof useGetAllDocumentsQuery>;
export type GetAllDocumentsLazyQueryHookResult = ReturnType<typeof useGetAllDocumentsLazyQuery>;
export type GetAllDocumentsQueryResult = Apollo.QueryResult<GetAllDocumentsQuery, GetAllDocumentsQueryVariables>;
export const GetAllFoldersDocument = gql`
    query getAllFolders {
  allFolders {
    id
    name
    key: id
    label: name
    parentFolderId
  }
}
    `;

/**
 * __useGetAllFoldersQuery__
 *
 * To run a query within a React component, call `useGetAllFoldersQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetAllFoldersQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetAllFoldersQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetAllFoldersQuery(baseOptions?: Apollo.QueryHookOptions<GetAllFoldersQuery, GetAllFoldersQueryVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetAllFoldersQuery, GetAllFoldersQueryVariables>(GetAllFoldersDocument, options);
      }
export function useGetAllFoldersLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetAllFoldersQuery, GetAllFoldersQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetAllFoldersQuery, GetAllFoldersQueryVariables>(GetAllFoldersDocument, options);
        }
export type GetAllFoldersQueryHookResult = ReturnType<typeof useGetAllFoldersQuery>;
export type GetAllFoldersLazyQueryHookResult = ReturnType<typeof useGetAllFoldersLazyQuery>;
export type GetAllFoldersQueryResult = Apollo.QueryResult<GetAllFoldersQuery, GetAllFoldersQueryVariables>;