import React from 'react'
import { Button } from 'primereact/button';
import { InputText } from "primereact/inputtext";

const SearchButton = () => {
    const [isSearching, setSearching] = React.useState(false)

    if (isSearching) {
        return (
                <div className="p-inputgroup p-mr-2">
                    <Button label="Search"/>
                    <InputText placeholder="Keyword"/>
                </div>
        )
    } else {
        return (
            <Button icon="pi pi-search" className="p-mr-2" onClick={() => setSearching(b => !b)} />
        )
    }
}

export default SearchButton
