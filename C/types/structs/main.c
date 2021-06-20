#include <stdio.h>
#include <string.h>

struct Note {
    int id;
    char content[500];
};

int get_id() {
    // A static variable preserves it value even
    // after it leaves its scope
    // so the function will "remember" the value of the variable
    // this function will return an incremented number after every call
    //
    // A very nice way to assign IDs
    static int id = 0;
    id++;
    return id;
}

// this function receives not the struct itself
// but a pointer to that struct
void print_note(struct Note* note) {
    printf(
        "%d: %s\n",
        // "->" operator is access a struct field from its pointer
        note->id,
        note->content
    );
}

// this function struct as values
struct Note merge_notes(struct Note n1, struct Note n2) {
    struct Note new_note;
    // "." operator is access a struct field directly
    new_note.id = get_id();
    strcpy(
        new_note.content,
        strcat(n1.content, n2.content)
    );
    return new_note;
}

struct Note* extend_note(struct Note* n1, struct Note n2) {
    strcpy(
        n1->content,
        strcat(n1->content, n2.content)
    );
    return n1;
}

int main(int argc, char *argv[]) {
    struct Note n1;
    struct Note n2;
    struct Note n3;

    n1.id = get_id();
    strcpy(n1.content, "foo");

    n2.id = get_id();
    strcpy(n2.content, "bar");

    print_note(&n1);
    print_note(&n2);

    n3 = merge_notes(n1, n2);
    print_note(&n3);

    extend_note(&n2, n3);
    print_note(&n2);

    return 0;
}
