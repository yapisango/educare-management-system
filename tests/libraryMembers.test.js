const response = await fetch("http://localhost:8000/api/v1/library/members");

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

if (body.data.length !== 1000) {
    throw new Error(`Expected 1000 members, but received ${body.data.length}`);
}

const membershipTypes = body.data.reduce((counts, member) => {
    counts[member.membership_type] =
        (counts[member.membership_type] || 0) + 1;

    return counts;
}, {});

if (membershipTypes.LEARNER !== 800) {
    throw new Error(`Expected 800 learner members, but received ${membershipTypes.LEARNER || 0}`);
}

if (membershipTypes.EMPLOYEE !== 110) {
    throw new Error(`Expected 110 employee members, but received ${membershipTypes.EMPLOYEE || 0}`);
}

if (membershipTypes.GUARDIAN !== 90) {
    throw new Error(`Expected 90 guardian members, but received ${membershipTypes.GUARDIAN || 0}`);
}

const firstMember = body.data[0];

if (
    !firstMember.id ||
    !firstMember.membership_number ||
    !firstMember.membership_type ||
    !firstMember.first_name ||
    !firstMember.last_name
) {
    throw new Error("First member is missing required fields");
}

console.log("Library members API test passed");
console.log(`Members returned: ${body.data.length}`);
console.log(`Learners: ${membershipTypes.LEARNER}`);
console.log(`Employees: ${membershipTypes.EMPLOYEE}`);
console.log(`Guardians: ${membershipTypes.GUARDIAN}`);
console.log(`First member: ${firstMember.first_name} ${firstMember.last_name}`);
