
U0 ProccessLine(U8 *line, I64 len, I64 *answer) {
  if (len <= 0) return;

  I64 max = 0;
  I64 first_digit = line[0] - '0';

  for(I64 i = 1; i < len; i++) {
    I64 current = line[i] - '0';
    I64 maybe = first_digit * 10 + current;

    if (maybe > max) max = maybe;
    if (current > first_digit) first_digit = current;

    "%c", line[i];
  }
  *answer += max;
  " | Largest: %3d\n", max;
}

U8 Main(I32 argc, U8 **argv) {
  I64 len = 0;
  I64 answer = 0;
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
  while (buffer[i]) {
    I64 start = i;

    while (buffer[i] && buffer[i] != '\n') {
      i++;
    }

    I64 end = i;
    ProccessLine(buffer + start, end - start, &answer);

    if (buffer[i] == '\n') {
      i++;
    }
  }

  "Answer: %d\n", answer;
  
  Free(buffer);
  return 0;
}
