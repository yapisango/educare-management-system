const response = await fetch("http://localhost:8000/api/v1/library/fines");

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

if (body.data.length !== 5) {
    throw new Error(`Expected 5 fines, but received ${body.data.length}`);
}

const fineStatuses = body.data.reduce((counts, fine) => {
    counts[fine.status] =
        (counts[fine.status] || 0) + 1;

    return counts;
}, {});

if (fineStatuses.OUTSTANDING !== 5) {
    throw new Error(
        `Expected 5 outstanding fines, but received ${fineStatuses.OUTSTANDING || 0}`
    );
}

const totalAmount = body.data.reduce(
    (total, fine) => total + Number(fine.amount),
    0
);

const totalAmountPaid = body.data.reduce(
    (total, fine) => total + Number(fine.amount_paid),
    0
);

if (totalAmount !== 125) {
    throw new Error(
        `Expected total fines of 125, but received ${totalAmount}`
    );
}

if (totalAmountPaid !== 0) {
    throw new Error(
        `Expected total amount paid of 0, but received ${totalAmountPaid}`
    );
}

const firstFine = body.data[0];

if (
    !firstFine.id ||
    !firstFine.public_id ||
    !firstFine.fine_type ||
    !firstFine.amount ||
    !firstFine.issued_date ||
    !firstFine.status ||
    !firstFine.loan_id ||
    !firstFine.book_copy_id ||
    !firstFine.book_id ||
    !firstFine.title ||
    !firstFine.library_member_id ||
    !firstFine.membership_number ||
    !firstFine.member_first_name ||
    !firstFine.member_last_name
) {
    throw new Error("First fine is missing required fields");
}

console.log("Library fines API test passed");
console.log(`Fines returned: ${body.data.length}`);
console.log(`Outstanding: ${fineStatuses.OUTSTANDING}`);
console.log(`Total amount: R${totalAmount.toFixed(2)}`);
console.log(`Total amount paid: R${totalAmountPaid.toFixed(2)}`);
console.log(`First book: ${firstFine.title}`);
console.log(
    `First member: ${firstFine.member_first_name} ${firstFine.member_last_name}`
);