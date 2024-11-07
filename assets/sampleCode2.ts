interface Person {
  name: string
  age: number
}

// @code-ai create function that, given a Person array deduplicate by name and sorts by age
function deduplicateAndSortByAge(persons: Person[]): Person[] {
  const uniqueMap = new Map<string, Person>();
  
  for (const person of persons) {
    if (!uniqueMap.has(person.name) || uniqueMap.get(person.name)!.age > person.age) {
      uniqueMap.set(person.name, person);
    }
  }

  return Array.from(uniqueMap.values()).sort((a, b) => a.age - b.age);
}


