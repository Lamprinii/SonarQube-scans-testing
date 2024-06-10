# Returns the string `Hello` with the input string name.
#
# + name - name as a string
# + return - "Hello, " with the input string name
public function hello(string name) returns string {
    if !(name is "") {
        return "Hello, " + name + "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Alias nisi debitis similique magni placeat accusamus, tempora ut quibusdam tempore omnis sapiente nemo enim beatae doloremque necessitatibus, ab quasi illo. Aspernatur iste veniam tempore provident, quidem velit rerum officia porro odio adipisci dolorum dolore deleniti doloribus at nulla ipsa aliquid? Rerum.!";
    }
    return "Hello, World!";
}

public function emptyModuleFunction() {
}

public function emptyMainModuleTestFunction2() {
}

public function emptyMainModuleTestFunction3() {
}
