<p align="center">
  <img src="https://img.shields.io/badge/SystemVerilog-IEEE%201800--2017-blue?style=for-the-badge&logo=verilog&logoColor=white" alt="SystemVerilog"/>
  <img src="https://img.shields.io/badge/Purpose-Verification-green?style=for-the-badge" alt="Verification"/>
  <img src="https://img.shields.io/badge/License-MIT-orange?style=for-the-badge" alt="License"/>
  <img src="https://img.shields.io/github/last-commit/EswarAdithya011/SystemVerilog-Concepts?style=for-the-badge&color=purple" alt="Last Commit"/>
  <img src="https://img.shields.io/github/repo-size/EswarAdithya011/SystemVerilog-Concepts?style=for-the-badge&color=red" alt="Repo Size"/>
</p>

<h1 align="center">🔬 SystemVerilog Concepts — A Verification-Focused Reference</h1>

<p align="center">
  <b>A comprehensive, self-contained collection of SystemVerilog (IEEE 1800) examples covering OOP, constrained-random verification, assertions (SVA), inter-process communication, interfaces, and more — all structured for quick lookup and deep understanding.</b>
</p>

<p align="center">
  <a href="#-about-this-repository">About</a> •
  <a href="#-concepts-covered">Concepts</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-repository-structure">Structure</a> •
  <a href="#-how-to-use">How to Use</a> •
  <a href="#-resources">Resources</a> •
  <a href="#-license">License</a>
</p>

---

## 📖 About This Repository

This repository is a **structured learning lab** for SystemVerilog verification concepts as defined by the **IEEE 1800 standard**. Each file is a **self-contained, commented example** that demonstrates a specific concept — from basic data types and OOP fundamentals to advanced constrained-random verification, functional coverage, and SystemVerilog Assertions (SVA).

### Who Is This For?

| Audience | Value |
|:---------|:------|
| 🎓 **Students & Self-Learners** | Concept-by-concept examples with clear comments to accelerate learning |
| 💼 **Job Seekers** | Quick revision of industry-relevant verification topics before interviews |
| 👨‍💻 **Verification Engineers** | Handy reference for syntax and usage patterns |
| 🔍 **Recruiters / Hiring Managers** | Evidence of hands-on practice across core SV/verification skill areas |

### Key Highlights

- ✅ **60+ working examples** covering all major SystemVerilog verification topics
- ✅ Covers **OOP**, **Constrained-Random Verification (CRV)**, **SVA**, **IPC**, **Interfaces**, and more
- ✅ Each file includes **inline comments** explaining the *what* and *why*
- ✅ Follows **IEEE 1800-2017** standard conventions
- ✅ Multi-file examples organized in dedicated directories (e.g., `design.sv` + `testbench.sv`)

---

## 📚 Concepts Covered

> All files are `.sv` (SystemVerilog) unless otherwise noted. Click any link to jump directly to the source code.

---

### 1️⃣ Data Types, Structures & Unions

Fundamental building blocks of SystemVerilog — packed/unpacked data structures, type casting, and string handling.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Packed Arrays | [`Packed Arrays.sv`](Packed%20Arrays.sv) | Contiguous bit-level storage; bit-slicing and vector operations |
| 2 | Packed Structures | [`Packed Structures.sv`](Packed%20Structures.sv) | Structs stored as a single contiguous vector for RTL mapping |
| 3 | Unpacked Structures | [`Unpacked Structures.sv`](Unpacked%20Structures.sv) | Structs with individually addressable members |
| 4 | Packed Unions | [`Packed Unions.sv`](Packed%20Unions.sv) | Overlapping storage with type punning — useful in protocol modeling |
| 5 | Unpacked Unions | [`Unpacked Unions.sv`](Unpacked%20Unions.sv) | Unions with separate member storage |
| 6 | Type Conversion | [`Type Conversion.sv`](Type%20Conversion.sv) | Static casting, `$cast`, and signed/unsigned conversions |

---

### 2️⃣ Strings

SystemVerilog string data type, built-in methods, operators, and format conversion.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Basic String Methods | [`Basic String Methods.sv`](Basic%20String%20Methods.sv) | `len()`, `getc()`, `putc()`, `substr()`, `toupper()`, `tolower()` |
| 2 | String Operators | [`String Operators.sv`](String%20Operators.sv) | Concatenation, comparison, replication operators |
| 3 | String Conversion Methods | [`String Conversion Methods.sv`](String%20Conversion%20Methods.sv) | `atoi()`, `atohex()`, `atobin()`, `atoreal()`, `itoa()` and more |
| 4 | IEEE 1800.2023 Triple-Quoted String | [`IEEE 1800.2023 Triple-Quoted String.sv`](IEEE%201800.2023%20Triple-Quoted%20String.sv) | Multi-line string literals from the latest standard revision |

---

### 3️⃣ Arrays & Collections

Dynamic data structures essential for building flexible testbenches.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Queues | [`Queues.sv`](Queues.sv) | Variable-size ordered collection; `push_back`, `pop_front`, FIFO/LIFO |
| 2 | Associative Array Methods | [`Associative Array Methods.sv`](Associative%20Array%20Methods.sv) | Sparse arrays indexed by arbitrary key types; `exists()`, `delete()` |
| 3 | Array Locator Methods (with Clause) | [`Array Locator Methods (with Clause).sv`](Array%20Locator%20Methods%20(with%20Clause).sv) | `find()`, `find_index()`, `min()`, `max()` with filtering clauses |
| 4 | Array Locator Methods (Optional Clause) | [`Array Locator Methods (with Clause Optional).sv`](Array%20Locator%20Methods%20(with%20Clause%20Optional).sv) | Locator methods without mandatory `with` clause |

---

### 4️⃣ Object-Oriented Programming (OOP)

Industry-standard OOP constructs used extensively in UVM-based verification environments.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Constructor Initialization | [`Constructor Initialization.sv`](Constructor%20Initialization.sv) | `new()` constructor, default arguments, object creation |
| 2 | Inheritance | [`Inheritance.sv`](Inheritance.sv) | `extends` keyword, parent-child class hierarchy, `super` keyword |
| 3 | Polymorphism | [`Polymorphism.sv`](Polymorphism.sv) | Runtime method dispatch via base-class handles |
| 4 | Data Encapsulation | [`Data Encapsulation.sv`](Data%20Encapsulation.sv) | `local` and `protected` access modifiers |
| 5 | Abstract Class, Virtual & Pure Virtual Methods | [`Abstract Class, Virtual and Pure Virtual Methods.sv`](Abstract%20Class,%20Virtual%20and%20Pure%20Virtual%20Methods.sv) | `virtual class`, `pure virtual` functions — factory pattern foundations |
| 6 | Parameterized Class | [`Parameterized Class.sv`](Parameterized%20Class.sv) | Generic/template-style classes using `#(parameters)` |
| 7 | Singleton Class | [`Singleton Class.sv`](Singleton%20Class.sv) | Design pattern ensuring a single global instance |
| 8 | Shallow Copy | [`Shallow Copy.sv`](Shallow%20Copy.sv) | `new obj` copy — shared nested references |
| 9 | Deep Copy | [`Deep Copy.sv`](Deep%20Copy.sv) | Custom `copy()` method — independent nested object duplication |
| 10 | Extern & Static Keyword | [`Extern and Static Keyword.sv`](Extern%20and%20Static%20Keyword.sv) | Out-of-body method definitions, class-level static members |

---

### 5️⃣ Constrained-Random Verification (CRV)

The backbone of modern functional verification — generating intelligent, coverage-driven stimulus.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Randomize Function | [`Randomize Function.sv`](Randomize%20Function.sv) | `randomize()` method, `rand`/`randc` qualifiers |
| 2 | Constraint Randomization | [`Constraint Randomization.sv`](Constraint%20Randomization.sv) | `constraint` blocks, `inside`, `dist`, conditional constraints |
| 3 | Implication Operators | [`Implication Operators.sv`](Implication%20Operators.sv) | `->` (if-then) and `<->` (if-and-only-if) constraint operators |
| 4 | Soft Constraints | [`Soft Constraints.sv`](Soft%20Constraints.sv) | `soft` keyword — overridable default constraints |
| 5 | Static Constraints | [`Static Constraints.sv`](Static%20Constraints.sv) | Constraints shared across all instances of a class |
| 6 | Constraint Mode | [`Constraint Mode.sv`](Constraint%20Mode.sv) | `constraint_mode()` — enable/disable constraints at runtime |
| 7 | Constraints in Inheritance | [`Constraints in Inheritance.sv`](Constraints%20in%20Inheritance.sv) | Overriding and extending parent-class constraints |
| 8 | Controlling Randomization | [`Controlling Randomization.sv`](Controlling%20Randomization.sv) | `rand_mode()`, `std::randomize()`, inline constraints |
| 9 | solve…before Directive | [`solve before: Constraint Ordering Directive.sv`](solve%20before%3A%20Constraint%20Ordering%20Directive.sv) | Controlling the order of constraint solving for probability |
| 10 | Random in Range & Algorithms | [`Random in Range and Random Algorithms.sv`](Random%20in%20Range%20and%20Random%20Algorithms.sv) | `$urandom_range()`, seeding, and algorithm selection |
| 11 | Statistical Distribution Functions | [`Statistical Distribution System Functions.sv`](Statistical%20Distribution%20System%20Functions.sv) | `$dist_uniform`, `$dist_normal`, `$dist_exponential`, etc. |
| 12 | randcase | [`randcase: Weighted Random Selection Construct.sv`](randcase%3A%20Weighted%20Random%20Selection%20Construct.sv) | Weighted random branch selection without class overhead |
| 13 | randsequence | [`randsequence: Random Sequence Operation Generation.sv`](randsequence%3A%20Random%20Sequence%20Operation%20Generation.sv) | Grammar-based random sequence generation |

---

### 6️⃣ Functional Coverage

Measuring verification progress — ensuring all interesting scenarios are exercised.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Covergroup & Bins | [`covergroup_bins.sv`](covergroup_bins.sv) | `covergroup`, `coverpoint`, auto/explicit bins, `ignore_bins`, `illegal_bins` |
| 2 | Transition Bins | [`Transition Bins.sv`](Transition%20Bins.sv) | Value-transition coverage; `bins t = (0 => 1 => 2)` |
| 3 | Advanced Coverage | [`Advanced Coverage.sv`](Advanced%20Coverage.sv) | Cross coverage, `option.weight`, `type_option`, coverage merging |

---

### 7️⃣ SystemVerilog Assertions (SVA)

Formal and simulation-based property checking to catch design bugs early.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Immediate Assertions | [`Immediate Assertions/`](Immediate%20Assertions/) | Simple, procedural `assert` / `assume` / `cover` statements (design + testbench) |
| 2 | Concurrent Assertions & Timing Regions | [`Concurrent Assertions and Timing Regions.sv`](Concurrent%20Assertions%20and%20Timing%20Regions.sv) | Clock-based assertions, observed/reactive regions |
| 3 | Sequence Operators | [`Sequence Operators.sv`](Sequence%20Operators.sv) | `##`, `[*N]`, `[*M:N]`, `$`, consecutive repetition |
| 4 | Sequence Combining Operators | [`Sequence Combining Operators.sv`](Sequence%20Combining%20Operators.sv) | `and`, `or`, `intersect`, `within`, `throughout`, `first_match` |
| 5 | Properties, Sequences & Reset Handling | [`Properties, Sequences, and Reset Handling.sv`](Properties%2C%20Sequences%2C%20and%20Reset%20Handling.sv) | `property`, `disable iff`, `not`, assertion binding |

---

### 8️⃣ Processes, Tasks & Scheduling

Understanding simulation execution order and procedural constructs.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Procedural Blocks | [`Procedural Blocks/`](Procedural%20Blocks/) | `always_comb`, `always_ff`, `always_latch` — synthesizable blocks (design + testbench) |
| 2 | Final Block | [`Final Block.sv`](Final%20Block.sv) | `final` block — executes once at end of simulation |
| 3 | Static & Automatic Tasks | [`Static and Automatic Tasks.sv`](Static%20and%20Automatic%20Tasks.sv) | Variable lifetime: `static` vs `automatic` in tasks/functions |
| 4 | Event Control (Conditional & Sequential) | [`Event Control (Conditional and Sequential).sv`](Event%20Control%20(Conditional%20and%20Sequential).sv) | `@`, `wait`, level-sensitive and edge-triggered event control |

---

### 9️⃣ Inter-Process Communication (IPC)

Synchronization and communication primitives for concurrent testbench processes.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | SV Threads | [`SV Threads.sv`](SV%20Threads.sv) | `fork...join`, `fork...join_any`, `fork...join_none`, `wait fork`, `disable fork` |
| 2 | Event Synchronization & Scheduling | [`Event Synchronization and Scheduling.sv`](Event%20Synchronization%20and%20Scheduling.sv) | `event`, `->`, `@`, `wait()`, scheduling semantics |
| 3 | Semaphores | [`Semaphores.sv`](Semaphores.sv) | `semaphore` — mutual exclusion and resource arbitration |
| 4 | Mailbox | [`Mailbox.sv`](Mailbox.sv) | `mailbox` — type-safe FIFO channel for inter-process data exchange |

---

### 🔟 Interfaces, Packages & System Integration

Modular design and testbench architecture building blocks.

| # | Topic | File | Description |
|:-:|:------|:-----|:------------|
| 1 | Interfaces (Modports & Clocking Block) | [`Interfaces (Modports & Clocking Block)/`](Interfaces%20(Modports%20%26%20Clocking%20Block)/) | `interface`, `modport`, `clocking` — structured port connectivity (multi-file) |
| 2 | Virtual Interface | [`Virtual Interface/`](Virtual%20Interface/) | `virtual interface` — dynamic interface binding in class-based testbenches (multi-file with driver, monitor, transaction) |
| 3 | SV Packages | [`SV Packages.sv`](SV%20Packages.sv) | `package`, `import`, `export` — namespace management and reuse |
| 4 | Compilation Unit & Root Instance Scope | [`Compilation Unit and Root Instance Scope.sv`](Compilation%20Unit%20and%20Root%20Instance%20Scope.sv) | `$unit`, `$root` — scope resolution in multi-file projects |
| 5 | SV Direct Programming Interface (DPI) | [`SV Direct Programming Interface (DPI)/`](SV%20Direct%20Programming%20Interface%20(DPI)/) | C↔SV interoperability: `import "DPI-C"` / `export "DPI-C"` (includes `model.c`) |

---

## 📊 Topic Coverage at a Glance

```
Data Types & Structures  ██████████████████████████  6 examples
Strings                  ████████████████████        4 examples
Arrays & Collections     ████████████████████        4 examples
OOP Fundamentals         ██████████████████████████████████████████████████  10 examples
Constrained-Random (CRV) ██████████████████████████████████████████████████████████████████  13 examples
Functional Coverage      ███████████████             3 examples
SVA (Assertions)         █████████████████████████   5 examples
Processes & Tasks        ████████████████████        4 examples
IPC (Threads/Sync)       ████████████████████        4 examples
Interfaces & Packages    █████████████████████████   5 examples
                         ─────────────────────────────────────
                         Total: 58+ examples across 10 categories
```

---

## 🚀 Quick Start

### Prerequisites

Any **SystemVerilog-compatible simulator**:

| Simulator | Vendor | Type |
|:----------|:-------|:-----|
| **QuestaSim / ModelSim** | Siemens EDA | Commercial |
| **VCS** | Synopsys | Commercial |
| **Xcelium** | Cadence | Commercial |
| **Vivado XSIM** | AMD/Xilinx | Free (with Vivado) |
| **Verilator** | Open-source | Free |
| **EDA Playground** | Online | Free (browser-based) |

### Clone & Run

```bash
# 1. Clone the repository
git clone https://github.com/EswarAdithya011/SystemVerilog-Concepts.git
cd SystemVerilog-Concepts

# 2. Run any single-file example (QuestaSim)
vlog "Queues.sv"
vsim -c work.top -do "run -all; quit"

# 3. Run a multi-file example (e.g., Virtual Interface)
vlog Virtual\ Interface/*.sv
vsim -c work.tb_top -do "run -all; quit"

# 4. Or use EDA Playground (no install required)
#    → https://www.edaplayground.com
```

---

## 📁 Repository Structure

```
SystemVerilog-Concepts/
│
├── 📄 Single-File Examples (.sv)
│   ├── Packed Arrays.sv
│   ├── Queues.sv
│   ├── Constraint Randomization.sv
│   ├── Polymorphism.sv
│   ├── ... (40+ more files)
│   └── covergroup_bins.sv
│
├── 📂 Immediate Assertions/
│   ├── design.sv                    # DUT with assertion checks
│   └── testbench.sv                 # Testbench driving assertion scenarios
│
├── 📂 Interfaces (Modports & Clocking Block)/
│   ├── and_intf.sv                  # Interface definition
│   ├── design.sv                    # DUT using modport
│   └── testbench.sv                 # Testbench with clocking block
│
├── 📂 Procedural Blocks/
│   ├── design.sv                    # always_comb, always_ff, always_latch
│   └── testbench.sv                 # Stimulus and checking
│
├── 📂 SV Direct Programming Interface (DPI)/
│   ├── alu_design.sv                # ALU design module
│   ├── model.c                      # C reference model
│   └── testbench.sv                 # DPI import/export testbench
│
├── 📂 Virtual Interface/
│   ├── interface.sv                 # Interface with clocking block
│   ├── transaction.sv               # Transaction class
│   ├── driver.sv                    # Driver component
│   ├── monitor.sv                   # Monitor component
│   ├── design.sv                    # DUT
│   └── testbench.sv                 # Top-level testbench
│
├── 📄 LICENSE                       # MIT License
└── 📄 README.md                     # You are here
```

---

## 🛠 How to Use

1. **Browse by Topic** — Use the [Concepts Covered](#-concepts-covered) section to find a specific concept
2. **Click the Link** — Each row in the tables links directly to the source file
3. **Read the Comments** — Every file contains inline comments explaining the concept
4. **Run & Experiment** — Copy a file, modify it, and observe the behavior in your simulator
5. **Build Your Testbench** — Combine concepts (e.g., OOP + CRV + Coverage) to build real verification environments

---

## 🧠 Skills Demonstrated

This repository demonstrates practical proficiency in the following industry-relevant areas:

```
┌──────────────────────────────────────────────────────────────────┐
│                    VERIFICATION SKILL MAP                        │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────┐  ┌─────────────────┐  ┌────────────────┐  │
│  │   OOP in SV     │  │  Constrained    │  │  Functional    │  │
│  │  • Classes      │  │  Random Verif.  │  │  Coverage      │  │
│  │  • Inheritance  │  │  • Constraints  │  │  • Covergroups │  │
│  │  • Polymorphism │  │  • Distributions│  │  • Cross Cov.  │  │
│  │  • Encapsulat.  │  │  • solve…before │  │  • Trans. Bins │  │
│  └─────────────────┘  └─────────────────┘  └────────────────┘  │
│                                                                  │
│  ┌─────────────────┐  ┌─────────────────┐  ┌────────────────┐  │
│  │   SVA           │  │   IPC           │  │  Interfaces    │  │
│  │  • Immediate    │  │  • fork/join    │  │  • Modports    │  │
│  │  • Concurrent   │  │  • Semaphores   │  │  • Clocking    │  │
│  │  • Sequences    │  │  • Mailbox      │  │  • Virtual IF  │  │
│  │  • Properties   │  │  • Events       │  │  • DPI (C↔SV)  │  │
│  └─────────────────┘  └─────────────────┘  └────────────────┘  │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🔗 Resources & References

| Resource | Description |
|:---------|:------------|
| [IEEE Std 1800-2017](https://ieeexplore.ieee.org/document/8299595) | Official SystemVerilog Language Reference Manual (LRM) |
| [ChipVerify — SystemVerilog](https://www.chipverify.com/systemverilog/systemverilog-tutorial) | Beginner-friendly SV tutorials with examples |
| [Verification Academy](https://verificationacademy.com/) | Siemens EDA — UVM and SV methodology resources |
| [ASIC World — SystemVerilog](https://www.asic-world.com/systemverilog/) | Comprehensive SV reference |
| [EDA Playground](https://www.edaplayground.com/) | Free online simulator — run SV code in your browser |
| [Doulos — SV Golden Reference Guide](https://www.doulos.com/knowhow/systemverilog/) | Quick-reference for SV syntax and constructs |

---

## 📜 License

This project is licensed under the **MIT License** — see the [`LICENSE`](LICENSE) file for details.

---

<p align="center">
  <b>⭐ If you found this repository helpful, please consider giving it a star!</b>
  <br><br>
  <i>Built with 💻 and a passion for hardware verification.</i>
  <br><br>
  <a href="https://github.com/EswarAdithya011">
    <img src="https://img.shields.io/badge/GitHub-EswarAdithya011-181717?style=for-the-badge&logo=github" alt="GitHub Profile"/>
  </a>
  <a href="https://linkedin.com/in/eswar-adithya">
    <img src="https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin" alt="LinkedIn"/>
  </a>
</p>
