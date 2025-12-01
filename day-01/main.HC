I64 ParseInt(U8 *s, I64 len) {
  I64 pos = 0;
  I64 result = 0;

  while (pos < len && s[pos] >= '0' && s[pos] <= '9')  {
    result = result * 10 + (s[pos] - '0');
    pos++;
  }

  return result;
}

U0 ProccessLine(U8 *line, I64 len, U8 *dial, U64 *pass) {
  if (len <= 0) return;
  U8 first = line[0];

  U8 *rest = line + 1;
  I64 rest_len = len - 1;

  I64 value = ParseInt(rest, rest_len);

  U8 *let = line;
  if (let[0] == 'R') {
    *dial = (*dial + value) % 100;
    if (*dial < 0) *dial += 100;
  }

  if (let[0] == 'L') {
    *dial = (*dial - value) % 100;
    if (*dial < 0) *dial += 100;
  }

  if (*(dial) == 0 ) {
    (*pass)++;
  }
  "Rotation: %c | Number: %4d | Dial: %2d\n", first, value, (*dial);
}

U8 Main(I32 argc, U8 **argv) {
  I64 len = 0;
  I64 dial = 50;
  I64 pass = 0;
  if (argc != 2) {
    "Usage: %s FILE_WITH_TOKENS\n", argv[0];
    return -1;
  }
  U8 *buffer = FileRead(argv[1], &len);

  if (!buffer) {
    "[Err] Failed to read the file\n";
    return 1;
  }

  I64 i = 0;
  "Dial is at: %d\n", dial;
  while (buffer[i]) {
    I64 start = i;

    while (buffer[i] && buffer[i] != '\n') {
      i++;
    }

    I64 end = i;

    ProccessLine(buffer + start, end - start, &dial, &pass);

    if (buffer[i] == '\n') {
      i++;
    }
  }
  
  "Password: %d\n", pass;

  Free(buffer);
  return 0;
}
