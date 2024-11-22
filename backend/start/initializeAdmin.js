import Role from "../models/roleModel.js";

const initializeRoles = async () => {
  try {
    const roles = ["admin", "user"];
    for (const role of roles) {
      const existingRole = await Role.findOne({ name: role });
      if (!existingRole) {
        await Role.create({ name: role });
        console.log(`Role '${role}' created.`);
      }
    }
  } catch (error) {
    console.error("Error initializing roles:", error.message);
  }
};

export default initializeRoles;
