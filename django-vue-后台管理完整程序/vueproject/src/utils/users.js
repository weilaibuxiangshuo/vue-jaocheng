export  function  deepCopyData(data) {
  const temp = data.constructor === Array ? [] : {};
  Object.keys(data).forEach(key => {
    if (data.constructor === Array) {
      temp[key] = deepCopyData(data[key]);
    } else {
      temp[key] = data[key];
    }
  });
  return temp;
}