// lib/apolloClient.js

import {
    ApolloProvider,
    ApolloClient,
    HttpLink,
    from,
    InMemoryCache,
} from "@apollo/client";
import React from "react";

const hasuraGraphqlApi = '/graphql/demo1';

export const ApolloProviderWrapper: React.FC = ({ children }) => {
    const httpLink = new HttpLink({
        uri: hasuraGraphqlApi,
    });

    const apolloClient = new ApolloClient({
        link: from([httpLink]),
        cache: new InMemoryCache(),
    });

    return <ApolloProvider client = { apolloClient }>{children}</ApolloProvider>;
};
