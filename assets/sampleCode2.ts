interface Person {
  name: string
}

// @code-ai create function that deduplicate and sorts a Person array
function deduplicateAndSortPersons(persons: Person[]): Person[] {
  const uniquePersons = new Map<string, Person>();

  for (const person of persons) {
    if (!uniquePersons.has(person.name)) {
      uniquePersons.set(person.name, person);
    }
  }

  return Array.from(uniquePersons.values()).sort((a, b) => a.name.localeCompare(b.name));
}

