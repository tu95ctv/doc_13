
export default function list_to_tree(list: undefined | any[], handler = (x: any) => x) {
    if (list === undefined) return []
   
    var map: any = {},
      node,
      roots = [],
      i;
  
    for (i = 0; i < list.length; i += 1) {
      map[list[i].id] = i; // initialize the map
      list[i].children = []; // initialize the children
      list[i].isLeaf = true;
    }
  
    console.log('list', list[0])
    for (i = 0; i < list.length; i += 1) {
      node = list[i];
      if (node.parent_id) {
        // if you have dangling branches check that map[node.parentId] exists
        list[map[node.parent_id]].children.push(handler(node));
        list[map[node.parent_id]].isLeaf = false;
      } else {
        roots.push(handler(node));
      }
    }
    return roots;
  }