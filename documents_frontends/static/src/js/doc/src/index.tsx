import React, { Suspense } from "react";
import * as ReactDOM from "react-dom";
import App from "./App";
import ErrorBoundary from "./ErrorBoundary";
import 'primereact/resources/themes/mdc-light-indigo/theme.css';
import 'primereact/resources/primereact.min.css';
import 'primeicons/primeicons.css';
import 'primeflex/primeflex.css';
import { store } from './app/store';
import { Provider } from 'react-redux';
import { ApolloProviderWrapper } from './apolloClient'
ReactDOM.render((
    <React.StrictMode>
    <Provider store={store}>
    <ErrorBoundary fallback={<h2>There is error.</h2>}>
    <Suspense fallback={<h1>Loading...</h1>}>
        <ApolloProviderWrapper>
                <App  />
                </ApolloProviderWrapper>
            </Suspense>
            </ErrorBoundary>
            </Provider></React.StrictMode>
), document.getElementById("root"));
