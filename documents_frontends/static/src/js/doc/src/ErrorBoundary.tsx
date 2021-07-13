import React from 'react'
class ErrorBoundary extends React.Component<any, any> {
    state = { hasError: false, error: null };
    static getDerivedStateFromError(error: any) {
        console.log('error', error)
        return {
            hasError: true,
            error
        };
    }
    render() {
        if (this.state.hasError) {
            return (this.props as any).fallback;
        }
        return this.props.children;
    }
}
export default ErrorBoundary