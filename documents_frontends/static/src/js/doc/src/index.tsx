import React, { Suspense } from "react";
import * as ReactDOM from "react-dom";
import App from "./App";
import ErrorBoundary from "./ErrorBoundary";
import 'primereact/resources/themes/mdc-light-indigo/theme.css';
import 'primereact/resources/primereact.min.css';
import 'primeicons/primeicons.css';
import 'primeflex/primeflex.css';
import { ApolloProviderWrapper } from './apolloClient'
ReactDOM.render((
    <ErrorBoundary fallback={<h2>There is error.</h2>}>
    <Suspense fallback={<h1>Loading...</h1>}>
        <ApolloProviderWrapper>
                <App  />
                </ApolloProviderWrapper>
            </Suspense>
            </ErrorBoundary>
), document.getElementById("root"));
