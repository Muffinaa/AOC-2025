U0 ProccessLine(U8 *line, I64 len, U64 *answer) {
  if (len <= 12) return;

  I64 n = 12;
  U8 result[13];
  I64 start = 0;

  for(I64 i = 0; i < n; i++) {
    U8 max_digit = '0';
    I64 max_index = start;

    for (I64 j = start; j <= len - (n - i); j++) {
      if (line[j] > max_digit) {
          max_digit = line[j];
          max_index = j;
        }
    }

    result[i] = max_digit;
    start = max_index + 1;
  }

  result[n] = '\0';

  U64 result_int = 0;
  for (U64 i = 0; i<n;i++) {
    result_int = result_int * 10 + (result[i] - '0');
  }
  *answer += result_int;
  "Largest: %s\n", result;
}

U8 Main(I32 argc, U8 **argv) {
  I64 len = 0;
  U64 answer = 0;
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

  "Answer: %lld\n", answer;
  
  Free(buffer);
  return 0;
}
