const response = await fetch("http://localhost:8000/api/v1/library/loans");

if (!response.ok) {
    throw new Error(`HTTP request failed with status ${response.status}`);
}

const body = await response.json();

if (body.success !== true) {
    throw new Error("API response success flag is not true");
}

if (!Array.isArray(body.data)) {
    throw new Error("API response data is not an array");
}

if (body.data.length !== 15) {
    throw new Error(`Expected 15 loans, but received ${body.data.length}`);
}

const loanStatuses = body.data.reduce((counts, loan) => {
    counts[loan.status] =
        (counts[loan.status] || 0) + 1;

    return counts;
}, {});

if (loanStatuses.RETURNED !== 5) {
    throw new Error(
        `Expected 5 returned loans, but received ${loanStatuses.RETURNED || 0}`
    );
}

if (loanStatuses.OVERDUE !== 5) {
    throw new Error(
        `Expected 5 overdue loans, but received ${loanStatuses.OVERDUE || 0}`
    );
}

if (loanStatuses.BORROWED !== 5) {
    throw new Error(
        `Expected 5 borrowed loans, but received ${loanStatuses.BORROWED || 0}`
    );
}

const firstLoan = body.data[0];

if (
    !firstLoan.id ||
    !firstLoan.public_id ||
    !firstLoan.loan_date ||
    !firstLoan.due_date ||
    !firstLoan.status ||
    !firstLoan.book_id ||
    !firstLoan.title ||
    !firstLoan.book_copy_id ||
    !firstLoan.library_member_id ||
    !firstLoan.membership_number
) {
    throw new Error("First loan is missing required fields");
}

console.log("Library loans API test passed");
console.log(`Loans returned: ${body.data.length}`);
console.log(`Returned: ${loanStatuses.RETURNED}`);
console.log(`Overdue: ${loanStatuses.OVERDUE}`);
console.log(`Borrowed: ${loanStatuses.BORROWED}`);
console.log(`First book: ${firstLoan.title}`);