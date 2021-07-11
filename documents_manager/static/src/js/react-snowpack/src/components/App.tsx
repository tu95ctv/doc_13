/* eslint-disable prettier/prettier */
import { ChakraProvider, Heading, Box } from "@chakra-ui/react";
import React from "react";
import { List, ListItem, ListIcon, OrderedList, UnorderedList } from "@chakra-ui/react"
const App: React.FC = () => {
  return (
    <ChakraProvider>
      <Box margin="100px">
      <Heading size="lg">Hello! You made it again! 2</Heading>
      <UnorderedList>
  <ListItem>Lorem ipsum dolor sit amet</ListItem>
  <ListItem>Consectetur adipiscing elit</ListItem>
  <ListItem>Integer molestie lorem at massa</ListItem>
  <ListItem>Facilisis in pretium nisl aliquet</ListItem>
</UnorderedList>
</Box>
    </ChakraProvider>
  );
};

export default App;
