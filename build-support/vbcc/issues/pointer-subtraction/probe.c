/* Compile separately from check.c. All pointer arithmetic is within records[]. */
struct record {
    char *text;
    unsigned length;
    char *key;
    unsigned key_length;
};
extern struct record *top;
extern unsigned count;

void put_record(char *text, unsigned length)
{
    struct record *r;
    r = top - (count + 1);
    r->text = text;
    r->length = length;
}
