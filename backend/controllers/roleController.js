import Role from "../models/roleModel.js";

const getRoles = async (req, res) => {
  try {
    const roles = await Role.find();
    res.status(200).json(roles);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const getRoleById = async (req, res) => {
  try {
    const role = await Role.findById(req.params.id);
    if (!role) {
      return res.status(404).json({ message: "Role not found" });
    }
    res.status(200).json(role);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const createRole = async (req, res) => {
  const { name } = req.body;
  try {
    const role = await Role.create({ name });
    res.status(201).json(role);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const updateRole = async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;
  try {
    const updatedRole = await Role.findByIdAndUpdate(id, { name }, { new: true });
    if (!updatedRole) {
      return res.status(404).json({ message: "Role not found" });
    }
    res.status(200).json(updatedRole);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const deleteRole = async (req, res) => {
  const { id } = req.params;
  try {
    const deletedRole = await Role.findByIdAndDelete(id);
    if (!deletedRole) {
      return res.status(404).json({ message: "Role not found" });
    }
    res.status(200).json({ message: "Role deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export { getRoles, getRoleById, createRole, updateRole, deleteRole };
