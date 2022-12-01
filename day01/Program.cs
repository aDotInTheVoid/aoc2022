// See https://aka.ms/new-console-template for more information
string input = System.IO.File.ReadAllText("input.txt");

string[] elves = input.Split("\n\n");


long sumElf(string[] sums)
{
    long sum = 0;
    foreach (string s in sums)
    {
        if (s == "")
            continue;
        sum += Int64.Parse(s);
    }
    return sum;
}

long maxSum = elves.Select(x => sumElf(x.Split("\n"))).Max();

Console.WriteLine(maxSum);