const DifField = (props) => {
  const { entry, exit } = props;
  const parsedEntry = parseInt(entry);
  const parsedExit = parseInt(exit);
  let value;

  if (isNaN(parsedEntry) || isNaN(parsedExit)) {
    value = '';
  } else {
    value = parsedExit - parsedEntry;
  }

  return (
    <input type="text" value={value} className="form-control" disabled={true} />
  )
};
