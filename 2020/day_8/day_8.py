with open("input.txt", "r") as f:
    instructions = []
    for line in f:
        op, arg = line.split()
        instructions.append((op, int(arg)))


class GameConsole:

    def __init__(self, instructions):
        self.instructions = instructions

    def run(self, hook=None):
        self.ip = 0
        self.acc = 0
        while self.ip < len(self.instructions):
            op, arg = self.instructions[self.ip]
            if hook is not None:
                result = hook()
                if result is not None:
                    return result
            if op == "acc":
                self.acc += arg
                self.ip += 1
            elif op == "jmp":
                self.ip += arg
            elif op == "nop":
                self.ip += 1
            else:
                raise ValueError(f"Unknown operation: {op}")

    def part_1_hook(self):
        if not hasattr(self, "seen_instructions"):
            self.seen_instructions = [False for __ in self.instructions]
        if self.seen_instructions[self.ip]:
            del self.seen_instructions
            return self.acc
        self.seen_instructions[self.ip] = True
        return None

    def part_2(self):
        for ip, (op, arg) in enumerate(self.instructions):
            if op == "acc":
                continue
            self.instructions[ip] = ({"jmp": "nop", "nop": "jmp"}[op], arg)
            result = self.run(hook=self.part_1_hook)
            if result is None:
                # reached the end
                return self.acc
            else:
                # saw an instruction twice
                self.instructions[ip] = (op, arg)


game = GameConsole(instructions)

print("Part 1:", game.run(hook=game.part_1_hook))
print("Part 2:", game.part_2())
