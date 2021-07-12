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
};

export type Document = {
  __typename?: 'Document';
  id: Scalars['Int'];
  name: Scalars['String'];
  folderId?: Maybe<Folder>;
};

export type FileInput = {
  name: Scalars['String'];
  type: Scalars['String'];
  blob: Scalars['String'];
};

export type Folder = {
  __typename?: 'Folder';
  id: Scalars['Int'];
  name: Scalars['String'];
  parentFolderId?: Maybe<ParentFolder>;
};

export type Mutation = {
  __typename?: 'Mutation';
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
  reverse: Scalars['String'];
  errorExample?: Maybe<Scalars['String']>;
};


export type QueryAllDocumentsArgs = {
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

export type GetAllFoldersQueryVariables = Exact<{ [key: string]: never; }>;


export type GetAllFoldersQuery = (
  { __typename?: 'Query' }
  & { allFolders: Array<(
    { __typename?: 'Folder' }
    & Pick<Folder, 'id' | 'name'>
  )> }
);


export const GetAllFoldersDocument = gql`
    query getAllFolders {
  allFolders {
    id
    name
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