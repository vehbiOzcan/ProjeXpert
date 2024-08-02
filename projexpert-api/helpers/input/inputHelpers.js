import bcyrpt from 'bcryptjs'

export const validateUserInput = (email,password) => {
    return email && password;
}

export const comparePassword = (password,hashedPassword) => {
    return bcyrpt.compareSync(password,hashedPassword);
}